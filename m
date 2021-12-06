Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A138146A230
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Dec 2021 18:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236999AbhLFRJK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Dec 2021 12:09:10 -0500
Received: from mga06.intel.com ([134.134.136.31]:29417 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235596AbhLFRF5 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Dec 2021 12:05:57 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="298155771"
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="298155771"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 09:01:29 -0800
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="460898846"
Received: from jcsee-mobl2.ccr.corp.intel.com (HELO [10.209.128.127]) ([10.209.128.127])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 09:01:28 -0800
Subject: Re: [PATCH v2] kselftest: alsa: Add simplistic test for ALSA mixer
 controls kselftest
To:     Mark Brown <broonie@kernel.org>
Cc:     Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
References: <20211206160305.194011-1-broonie@kernel.org>
 <33692870-fccc-6d63-2c95-056a21fff791@linux.intel.com>
 <Ya48u+Wx+ZZyfYIO@sirena.org.uk>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <b2972e61-e6c2-9f60-6242-3762c88efe0a@linux.intel.com>
Date:   Mon, 6 Dec 2021 11:01:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Ya48u+Wx+ZZyfYIO@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


>>> +// This test will iterate over all cards detected in the system, exercising
> 
>> would it make sense to test only specific cards? People doing automated
>> tests might have a USB device for capture of analog loopbacks, or
>> injection of specific streams for capture, and usually care about
>> testing such devices - which do need manual setups and wiring btw.
> 
> It's not really idiomatic for kselftest to require any per system
> configuration by default - half the thing is that you can just run it
> and it should do as much as it can sensibly on the system.  You could
> definitely add some command line options for development or manual usage
> though.

I was thinking of adding this test to our CI, it's a bit orthogonal to
self-tests indeed. IIRC we check that we can modify all the PGA settings
for volume control but this test is a lot more generic.
