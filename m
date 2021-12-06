Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC4646A159
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Dec 2021 17:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376850AbhLFQbi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Dec 2021 11:31:38 -0500
Received: from mga18.intel.com ([134.134.136.126]:13051 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1385827AbhLFQb0 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Dec 2021 11:31:26 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="224217125"
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="224217125"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 08:27:30 -0800
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="479170337"
Received: from jcsee-mobl2.ccr.corp.intel.com (HELO [10.209.128.127]) ([10.209.128.127])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 08:27:29 -0800
Subject: Re: [PATCH v2] kselftest: alsa: Add simplistic test for ALSA mixer
 controls kselftest
To:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>,
        Shuah Khan <shuah@kernel.org>, Jaroslav Kysela <perex@perex.cz>
Cc:     alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org
References: <20211206160305.194011-1-broonie@kernel.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <33692870-fccc-6d63-2c95-056a21fff791@linux.intel.com>
Date:   Mon, 6 Dec 2021 10:27:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211206160305.194011-1-broonie@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> This is added as a kselftest since unlike other ALSA test programs it does
> not require either physical setup of the device or interactive monitoring

what did you mean by 'not require physical setup of the device'?

> diff --git a/tools/testing/selftests/alsa/mixer-test.c b/tools/testing/selftests/alsa/mixer-test.c
> new file mode 100644
> index 000000000000..6082efa0b426
> --- /dev/null
> +++ b/tools/testing/selftests/alsa/mixer-test.c
> @@ -0,0 +1,616 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// kselftest for the ALSA mixer API
> +//
> +// Original author: Mark Brown <broonie@kernel.org>
> +// Copyright (c) 2021 Arm Limited
> +
> +// This test will iterate over all cards detected in the system, exercising

would it make sense to test only specific cards? People doing automated
tests might have a USB device for capture of analog loopbacks, or
injection of specific streams for capture, and usually care about
testing such devices - which do need manual setups and wiring btw.

> +	switch (snd_ctl_elem_info_get_type(ctl->info)) {
> +	case SND_CTL_ELEM_TYPE_NONE:
> +		ksft_print_msg("%s Invalid control type NONE\n", ctl->name);
> +		err = -1;
> +		break;
> +
> +	case SND_CTL_ELEM_TYPE_BOOLEAN:
> +		int_val = snd_ctl_elem_value_get_boolean(ctl->def_val, 0);
> +		switch (int_val) {
> +		case 0:
> +		case 1:
> +			break;
> +		default:
> +			ksft_print_msg("%s Invalid boolean value %ld\n",
> +				       ctl->name, int_val);
> +			err = -1;
> +			break;
> +		}
> +		break;
> +
> +	case SND_CTL_ELEM_TYPE_INTEGER:
> +		int_val = snd_ctl_elem_value_get_integer(ctl->def_val, 0);
> +
> +		if (int_val < snd_ctl_elem_info_get_min(ctl->info)) {
> +			ksft_print_msg("%s value %ld less than minimum %ld\n",
> +				       ctl->name, int_val,
> +				       snd_ctl_elem_info_get_min(ctl->info));
> +			err = -1;
> +		}
> +
> +		if (int_val > snd_ctl_elem_info_get_max(ctl->info)) {
> +			ksft_print_msg("%s value %ld more than maximum %ld\n",
> +				       ctl->name, int_val,
> +				       snd_ctl_elem_info_get_max(ctl->info));
> +			err = -1;
> +		}
> +
> +		/* Only check step size if there is one and we're in bounds */
> +		if (err >= 0 && snd_ctl_elem_info_get_step(ctl->info) &&
> +		    (int_val - snd_ctl_elem_info_get_min(ctl->info) %
> +		     snd_ctl_elem_info_get_step(ctl->info))) {
> +			ksft_print_msg("%s value %ld invalid for step %ld minimum %ld\n",
> +				       ctl->name, int_val,
> +				       snd_ctl_elem_info_get_step(ctl->info),
> +				       snd_ctl_elem_info_get_min(ctl->info));
> +			err = -1;
> +		}
> +		break;
> +
> +	case SND_CTL_ELEM_TYPE_INTEGER64:
> +		int64_val = snd_ctl_elem_value_get_integer64(ctl->def_val, 0);
> +
> +		if (int64_val < snd_ctl_elem_info_get_min64(ctl->info)) {
> +			ksft_print_msg("%s value %lld less than minimum %lld\n",
> +				       ctl->name, int64_val,
> +				       snd_ctl_elem_info_get_min64(ctl->info));
> +			err = -1;
> +		}
> +
> +		if (int64_val > snd_ctl_elem_info_get_max64(ctl->info)) {
> +			ksft_print_msg("%s value %lld more than maximum %lld\n",
> +				       ctl->name, int64_val,
> +				       snd_ctl_elem_info_get_max(ctl->info));
> +			err = -1;
> +		}
> +
> +		/* Only check step size if there is one and we're in bounds */
> +		if (err >= 0 && snd_ctl_elem_info_get_step64(ctl->info) &&
> +		    (int64_val - snd_ctl_elem_info_get_min64(ctl->info)) %
> +		    snd_ctl_elem_info_get_step64(ctl->info)) {
> +			ksft_print_msg("%s value %lld invalid for step %lld minimum %lld\n",
> +				       ctl->name, int64_val,
> +				       snd_ctl_elem_info_get_step64(ctl->info),
> +				       snd_ctl_elem_info_get_min64(ctl->info));
> +			err = -1;
> +		}
> +		break;
> +
> +	default:
> +		/* No tests for other types */

these types include ENUMERATED, BYTES and IEC958, but see below for
ENUMERATED...

> +		ksft_test_result_skip("get_value.%d.%d\n",
> +				      ctl->card->card, ctl->elem);
> +		return;
> +	}
> +
> +out:
> +	ksft_test_result(err >= 0, "get_value.%d.%d\n",
> +			 ctl->card->card, ctl->elem);
> +}
> +
> +bool show_mismatch(struct ctl_data *ctl, int index,
> +		   snd_ctl_elem_value_t *read_val,
> +		   snd_ctl_elem_value_t *expected_val)
> +{
> +	long long expected_int, read_int;
> +
> +	/*
> +	 * We factor out the code to compare values representable as
> +	 * integers, ensure that check doesn't log otherwise.
> +	 */
> +	expected_int = 0;
> +	read_int = 0;
> +
> +	switch (snd_ctl_elem_info_get_type(ctl->info)) {
> +	case SND_CTL_ELEM_TYPE_BOOLEAN:
> +		expected_int = snd_ctl_elem_value_get_boolean(expected_val,
> +							      index);
> +		read_int = snd_ctl_elem_value_get_boolean(read_val, index);
> +		break;
> +
> +	case SND_CTL_ELEM_TYPE_INTEGER:
> +		expected_int = snd_ctl_elem_value_get_integer(expected_val,
> +							      index);
> +		read_int = snd_ctl_elem_value_get_integer(read_val, index);
> +		break;
> +
> +	case SND_CTL_ELEM_TYPE_INTEGER64:
> +		expected_int = snd_ctl_elem_value_get_integer64(expected_val,
> +								index);
> +		read_int = snd_ctl_elem_value_get_integer64(read_val,
> +							    index);
> +		break;
> +
> +	case SND_CTL_ELEM_TYPE_ENUMERATED:

... here you are handling ENUMERATED types?

> +		expected_int = snd_ctl_elem_value_get_enumerated(expected_val,
> +								 index);
> +		read_int = snd_ctl_elem_value_get_enumerated(read_val,
> +							     index);
> +		break;
> +
> +	default:
> +		break;
> +	}
> +
> +	if (expected_int != read_int) {
> +		ksft_print_msg("%s.%d expected %lld but read %lld\n",
> +			       ctl->name, index, expected_int, read_int);
> +		return true;
> +	} else {
> +		return false;
> +	}
> +}

