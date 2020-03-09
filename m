Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B86B417EB74
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Mar 2020 22:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbgCIVo7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Mar 2020 17:44:59 -0400
Received: from mga01.intel.com ([192.55.52.88]:29758 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727233AbgCIVo4 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Mar 2020 17:44:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Mar 2020 14:44:55 -0700
X-IronPort-AV: E=Sophos;i="5.70,534,1574150400"; 
   d="scan'208";a="245476220"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.251.21.24]) ([10.251.21.24])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 09 Mar 2020 14:44:54 -0700
Subject: Re: [PATCH V1 01/13] selftests/resctrl: Fix feature detection
To:     Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        tony.luck@intel.com, babu.moger@amd.com, james.morse@arm.com,
        ravi.v.shankar@intel.com, fenghua.yu@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1583657204.git.sai.praneeth.prakhya@intel.com>
 <7e3e4b91f5786a489e68eecda21e1d8049b60181.1583657204.git.sai.praneeth.prakhya@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <a7407b0d-4e4d-d0cf-621c-769d218fdace@intel.com>
Date:   Mon, 9 Mar 2020 14:44:53 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <7e3e4b91f5786a489e68eecda21e1d8049b60181.1583657204.git.sai.praneeth.prakhya@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Sai,

On 3/6/2020 7:40 PM, Sai Praneeth Prakhya wrote:
> From: Reinette Chatre <reinette.chatre@intel.com>
> 
> The intention of the resctrl selftests is to only run the tests
> associated with the feature(s) supported by the platform. Through
> parsing of the feature flags found in /proc/cpuinfo it is possible
> to learn which features are supported by the plaform.
> 
> There are currently two issues with the platform feature detection that
> together result in tests always being run, whether the platform supports
> a feature or not. First, the parsing of the the feature flags loads the
> line containing the flags in a buffer that is too small (256 bytes) to
> always contain all flags. The consequence is that the flags of the features
> being tested for may not be present in the buffer. Second, the actual
> test for presence of a feature has an error in the logic, negating the
> test for a particular feature flag instead of testing for the presence of a
> particular feature flag.
> 
> These two issues combined results in all tests being run on all
> platforms, whether the feature is supported or not.
> 
> Fix these issue by (1) increasing the buffer size being used to parse
> the feature flags, and (2) change the logic to test for presence of the
> feature being tested for.
> 
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
> ---
>  tools/testing/selftests/resctrl/resctrlfs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
> index 19c0ec4045a4..226dd7fdcfb1 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -596,11 +596,11 @@ bool check_resctrlfs_support(void)
>  
>  char *fgrep(FILE *inf, const char *str)
>  {
> -	char line[256];
>  	int slen = strlen(str);
> +	char line[2048];
>  
>  	while (!feof(inf)) {
> -		if (!fgets(line, 256, inf))
> +		if (!fgets(line, 2048, inf))
>  			break;
>  		if (strncmp(line, str, slen))
>  			continue;
> @@ -631,7 +631,7 @@ bool validate_resctrl_feature_request(char *resctrl_val)
>  	if (res) {
>  		char *s = strchr(res, ':');
>  
> -		found = s && !strstr(s, resctrl_val);
> +		found = s && strstr(s, resctrl_val);
>  		free(res);
>  	}
>  	fclose(inf);
> 

Please note that this is only a partial fix. The current feature
detection relies on the feature flags found in /proc/cpuinfo. Quirks and
kernel boot parameters are not taken into account. This fix only
addresses the parsing of feature flags. If a feature has been disabled
via kernel boot parameter or quirk then the resctrl tests would still
attempt to run the test for it.

Reinette
