Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8144D77CA16
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 11:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjHOJLZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 05:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235942AbjHOJLJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 05:11:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDBA10C;
        Tue, 15 Aug 2023 02:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692090663; x=1723626663;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=/uBmNuSxoJxPuOjRNoh7lksd/Du0h97dGvJ9K4Zkd1Q=;
  b=MFguzRDzKvn9TMSUy0tfJTz3UQUrVrnr6l4t2idb1+woR52k1InpUy2D
   fjl2TTmHu6yT17fh3ZVJ85ZJnFws314N3Tu3dK/aZ1lycYvo0WS78qKy7
   KwJwcqaI8LQlcgNpH4kayS1FrFVinfj+Yueg/k9KDPweSAG3u1lV4+vN9
   sRnrzJwplQwdBuBlR1epmwvswhTfscxkLSABkZW0WnaBoiQgfZqLKni8i
   aCX1R3nQITFbY5pBWSFnIvemShuvs6BWVPN6dxf2RvKbb6AIfq6lDmkMx
   HDg2K8yMggS5rAv9gYxoLSNbwwiXrwF6TeYj4PjK+BYZ7NwQaZwpQWHtI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="403219325"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="403219325"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 02:11:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="907522120"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="907522120"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO ijarvine-mobl2.mshome.net) ([10.237.66.35])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 02:10:57 -0700
Date:   Tue, 15 Aug 2023 12:10:55 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Subject: Re: [PATCH 1/7] selftests/resctrl: Ensure the benchmark commands
 fits to its array
In-Reply-To: <9e56779c-4df0-654f-08e1-b27e0dd6b2ac@intel.com>
Message-ID: <12ce6b7a-292c-6f27-809e-a7cbb810f596@linux.intel.com>
References: <20230808091625.12760-1-ilpo.jarvinen@linux.intel.com> <20230808091625.12760-2-ilpo.jarvinen@linux.intel.com> <9e56779c-4df0-654f-08e1-b27e0dd6b2ac@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-836853079-1692083089=:1736"
Content-ID: <cd2f4ade-5e38-e297-43b2-a3c78add636@linux.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-836853079-1692083089=:1736
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <40ebe168-75b2-511-4fe3-77caf63ecfc3@linux.intel.com>

On Mon, 14 Aug 2023, Reinette Chatre wrote:
> On 8/8/2023 2:16 AM, Ilpo Järvinen wrote:
> > Benchmark command is copied into an array in the stack. The array is
> > BENCHMARK_ARGS items long but the command line could try to provide a
> > longer command.
> > 
> > Return error in case the benchmark command does not fit to its array.
> > 
> > Fixes: ecdbb911f22d ("selftests/resctrl: Add MBM test")
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  tools/testing/selftests/resctrl/resctrl_tests.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> > index d511daeb6851..eef9e02516ad 100644
> > --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> > +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> > @@ -255,6 +255,9 @@ int main(int argc, char **argv)
> >  		return ksft_exit_skip("Not running as root. Skipping...\n");
> >  
> >  	if (has_ben) {
> > +		if (argc - ben_ind >= BENCHMARK_ARGS - 1)
> > +			ksft_exit_fail_msg("Too long benchmark command");
> > +
> 
> I think there are two potential issues here: too many arguments and too
> long arguments. Current code can handle 64 (63 with last required to be
> NULL) arguments each expected to be 64 bytes (63 to end with \0).
> The above fix looks to be handling the first issue, with this the
> error message could be more accurate if it refers to the
> number of arguments instead. It looks to me as though the latter
> issue still needs to be handled. I understand that this becomes 
> unnecessary via the refactor in following patches but I expect that
> this fix needs to be backported (cc. stable also) and thus
> it may benefit from a precision added to the sprintf() that follows
> the snippet below?

Thanks for taking a look, yes, both are problems. Third problem which 
still remains is if "fill_buf" is the first argument of -b, the arguments 
are not validated to match the formatting used internally (I guess it 
might be intentional to allow overriding the internal fill_buf arguments 
but just the validation is lacking).

I'll add strlen() check instead of using sprintf() in order to properly 
fail rather than silently truncating the arguments.

> >  		/* Extract benchmark command from command line. */
> >  		for (i = ben_ind; i < argc; i++) {
> >  			benchmark_cmd[i - ben_ind] = benchmark_cmd_area[i];
> 
> Reinette
> 
> ps. Unless you have an updated email address that works, could you please
> remove Sai's email from future submissions?

It's auto-added by git send-email machinery. I guess I can try to make 
an exception to my usual workflow by sending only to manually specified To 
addresses (if I remember). Perhaps one day I'll write a tool to filter out
the addresses from git send-email generated ones but as is I don't have 
one.

-- 
 i.
--8323329-836853079-1692083089=:1736--
