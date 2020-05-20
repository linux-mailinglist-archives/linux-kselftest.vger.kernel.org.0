Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B383E1DC32F
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 May 2020 01:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgETXqc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 May 2020 19:46:32 -0400
Received: from mga14.intel.com ([192.55.52.115]:6822 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbgETXqb (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 May 2020 19:46:31 -0400
IronPort-SDR: A0K1RmyllVZaNRZpI/8U3jN0CnvoZCvDmHIsyhA7PVUlqK/63NTaSHNDVNzZwRarmTvEfGJRB6
 m2TRIuwKjT7A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 16:46:31 -0700
IronPort-SDR: dvE3QmgVy8lzhpwbM3DCo638YDuPkv2d5aXIQ4igI/lXdqo3pb61avUvTkiC3aKTdtlu751nJE
 ufWy8nXb9u/A==
X-IronPort-AV: E=Sophos;i="5.73,415,1583222400"; 
   d="scan'208";a="268434818"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.254.101.53]) ([10.254.101.53])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 16:46:30 -0700
Subject: Re: [PATCH V2 14/19] selftests/resctrl: Skip the test if requested
 resctrl feature is not supported
To:     Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        shuah@kernel.org, skhan@linuxfoundation.org,
        linux-kselftest@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        tony.luck@intel.com, babu.moger@amd.com, james.morse@arm.com,
        ravi.v.shankar@intel.com, fenghua.yu@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel, dan.carpenter@oracle.com,
        dcb314@hotmail.com
References: <cover.1589835155.git.sai.praneeth.prakhya@intel.com>
 <485f834d4f1188056b306263d800bffbc0c43430.1589835155.git.sai.praneeth.prakhya@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <6e12840d-d8fc-c8ef-cfad-eb8b514d3030@intel.com>
Date:   Wed, 20 May 2020 16:46:28 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <485f834d4f1188056b306263d800bffbc0c43430.1589835155.git.sai.praneeth.prakhya@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Sai,

On 5/18/2020 3:08 PM, Sai Praneeth Prakhya wrote:
> Presently, if a requested resctrl feature is not supported by H/W or is
> disabled by user through kernel command line, the test suite treats it as
> an error and hence would print something like "not ok MBA: schemata
> change". But, not supporting a feature isn't a test error and hence
> shouldn't printed as a failure.
> 
> So, instead of treating it as an error, use the SKIP directive of TAP
> protocol and print it as below i.e. don't report it as test failure.
> 
> Sample o/p if CAT isn't supported:
> "ok CAT # SKIP Hardware does not support CAT or CAT is disabled"
> 
> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
> ---

...

> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> index fb7703413be7..d45ae004ed77 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -170,6 +170,10 @@ int main(int argc, char **argv)
>  
>  	if (!is_amd && mbm_test) {
>  		printf("# Starting MBM BW change ...\n");
> +		if (!validate_resctrl_feature_request("mbm")) {
> +			printf("ok MBM # SKIP Hardware does not support MBM or MBM is disabled\n");
> +			goto test_mba;
> +		}
>  		if (!has_ben)
>  			sprintf(benchmark_cmd[5], "%s", "mba");
>  		res = mbm_bw_change(span, cpu_no, bw_report, benchmark_cmd);
> @@ -178,8 +182,13 @@ int main(int argc, char **argv)
>  		tests_run++;
>  	}
>  
> +test_mba:

I think this particular usage of goto could make the flow of the code
harder to trace. Could the tests perhaps be moved to functions to avoid
needing to jump like this? Perhaps there could be a new function per
test, like run_mbm_test(), run_mba_test(), etc. with each test called
when requested by user and with the test exiting cleanly if feature is
not supported by the hardware.

Reinette
