Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF4A508209
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Apr 2022 09:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359712AbiDTH1Y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Apr 2022 03:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359796AbiDTH1G (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Apr 2022 03:27:06 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5124E3A733;
        Wed, 20 Apr 2022 00:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650439434; x=1681975434;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VZ2QcDDsn09EZJ9ChcAfXKxOwF3NNkLHqhHF7SzxBPU=;
  b=iHRMumNbF95vnKvrnxk249pTvzggOv+FSA0pWFRYRev1dMzt8/S+MCQd
   G53B7X9dd/FgZeNbAILZcuEJv4fGXOamL+CYgL6I4hh/N7L0/PZxpgt86
   cL/Lv48w1jpx/he8gJP+SRQc5qD8gafitwmQwv6Jt2VQke4O27MMxFAs2
   Dx48uoPGygiznrfl2zub7ayJQQCVS6cw098qNgRya71EH2AbuZbUlLI2/
   chd+Lgr++YQFAPdZtTdN8NBLhZns7ouSb1XsYNr0SEjIYqXwLvb/ab7Hg
   PaWhPGnUnvKPgeeI1H/3ObqK4iQvsA0+ZzWMksat8dJA87gJqQHrRkjiM
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="350410498"
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="350410498"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 00:23:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="555076861"
Received: from xpf.sh.intel.com ([10.239.182.112])
  by orsmga007.jf.intel.com with ESMTP; 20 Apr 2022 00:23:49 -0700
Date:   Wed, 20 Apr 2022 15:22:32 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
        sandipan@linux.ibm.com, fweimer@redhat.com,
        desnesn@linux.vnet.ibm.com, mingo@kernel.org,
        bauerman@linux.ibm.com, mpe@ellerman.id.au, msuchanek@suse.de,
        linux-mm@kvack.org, chang.seok.bae@intel.com, bp@suse.de,
        tglx@linutronix.de, hpa@zytor.com, x86@kernel.org, luto@kernel.org,
        heng.su@intel.com
Subject: Re: [PATCH V2 1/4] selftests: Provide local define of __cpuid_count()
Message-ID: <Yl+0uGJMnJ0+mDhV@xpf.sh.intel.com>
References: <cover.1647360971.git.reinette.chatre@intel.com>
 <7c49dbfe5bab04389ed84c516fcbfe31d66df880.1647360971.git.reinette.chatre@intel.com>
 <Ylp1oFenjgxWpM0D@xpf.sh.intel.com>
 <50067c2d-5563-7d8c-f992-5fef787d4d38@intel.com>
 <Yl47IGLggYsFYolo@xpf.sh.intel.com>
 <a3ceede0-ebab-6586-dfd5-247c37b976ec@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3ceede0-ebab-6586-dfd5-247c37b976ec@intel.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2022-04-19 at 15:34:11 -0700, Reinette Chatre wrote:
> Hi Pengfei,
> 
> On 4/18/2022 9:31 PM, Pengfei Xu wrote:
> > On 2022-04-18 at 09:04:33 -0700, Reinette Chatre wrote:
> >> Hi Pengfei,
> >>
> >> On 4/16/2022 12:52 AM, Pengfei Xu wrote:
> >>> On 2022-03-15 at 09:44:25 -0700, Reinette Chatre wrote:
> >>>> Some selftests depend on information provided by the CPUID instruction.
> >>>> To support this dependency the selftests implement private wrappers for
> >>>> CPUID.
> >>>>
> >>>> Duplication of the CPUID wrappers should be avoided.
> >>>>
> >>>> Both gcc and clang/LLVM provide __cpuid_count() macros but neither
> >>>> the macro nor its header file are available in all the compiler
> >>>> versions that need to be supported by the selftests. __cpuid_count()
> >>>> as provided by gcc is available starting with gcc v4.4, so it is
> >>>> not available if the latest tests need to be run in all the
> >>>> environments required to support kernels v4.9 and v4.14 that
> >>>> have the minimal required gcc v3.2.
> >>>>
> >>>> Provide a centrally defined macro for __cpuid_count() to help
> >>>> eliminate the duplicate CPUID wrappers while continuing to
> >>>> compile in older environments.
> >>>>
> >>>> Suggested-by: Shuah Khan <skhan@linuxfoundation.org>
> >>>> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> >>>> ---
> >>>> Note to maintainers:
> >>>> - Macro is identical to the one provided by gcc, but not liked by
> >>>>   checkpatch.pl with message "Macros with complex values should
> >>>>   be enclosed in parentheses". Similar style is used in kernel,
> >>>>   for example in arch/x86/kernel/fpu/xstate.h.
> >>>>
> >>>>  tools/testing/selftests/kselftest.h | 15 +++++++++++++++
> >>>>  1 file changed, 15 insertions(+)
> >>>>
> >>>> diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
> >>>> index f1180987492c..898d7b2fac6c 100644
> >>>> --- a/tools/testing/selftests/kselftest.h
> >>>> +++ b/tools/testing/selftests/kselftest.h
> >>>> @@ -52,6 +52,21 @@
> >>>> + * have __cpuid_count().
> >>>> + */
> >>>> +#ifndef __cpuid_count
> >>>> +#define __cpuid_count(level, count, a, b, c, d)				\
> >>>> +	__asm__ __volatile__ ("cpuid\n\t"				\
> >>>> +			      : "=a" (a), "=b" (b), "=c" (c), "=d" (d)	\
> >>>> +			      : "0" (level), "2" (count))
> >>>> +#endif
> >>>    Linux C check tool "scripts/checkpatch.pl" shows an error:
> >>> "
> >>> ERROR: Macros with complex values should be enclosed in parentheses
> >>
> >> I encountered this also and that is why this patch contains the "Note to
> >> maintainers" above. It is not clear to me whether you considered the note
> >> since your response does not acknowledge it.
> >>
> >   Sorry, I just made a suggestion to fix this problem mentioned by the script.
> >   I didn't notice and reply for the note.
> > 
> >>> ...
> >>> +#define __cpuid_count(level, count, a, b, c, d)                        \
> >>> +       __asm__ __volatile__ ("cpuid\n\t"                               \
> >>> +                             : "=a" (a), "=b" (b), "=c" (c), "=d" (d)  \
> >>> +                             : "0" (level), "2" (count))
> >>> "
> >>> Googling:
> >>> https://www.google.com/search?q=Macros+with+complex+values+should+be+enclosed+in+parentheses&rlz=1C1GCEB_enUS884US884&oq=Macros+with+complex+values+should+be+enclosed+in+parentheses&aqs=chrome.0.69i59j0i5i30l2.313j0j7&sourceid=chrome&ie=UTF-8
> >>> -> https://stackoverflow.com/questions/8142280/why-do-we-need-parentheses-around-block-macro
> >>
> >> More information available in
> >> https://gcc.gnu.org/onlinedocs/gcc/Statement-Exprs.html#Statement-Exprs
> >> but from what I understand it does not apply to this macro. Even so, I do
> >> not know what checkpatch.pl uses to determine that this is a "Macro with
> >> complex values".
> >>
> >   Checked checkpatch.pl and it seems to suggest using ({ }) for any asm macro
> >   definition.
> > 
> >>>
> >>> Could we fix it as follow, shall we?
> >>> "
> >>> #ifndef __cpuid_count
> >>> #define __cpuid_count(level, count, a, b, c, d) ({			\
> >>> 	__asm__ __volatile__ ("cpuid\n\t"				\
> >>> 			      : "=a" (a), "=b" (b), "=c" (c), "=d" (d)	\
> >>> 			      : "0" (level), "2" (count))		\
> >>> })
> >>> #endif
> >>> "
> >>
> >> Sure, I can do so.
> >>
> >   I just made a suggestion to fix the problem reported by the checkpatch.pl.
> >   But I didn't think deeply enough before: I'm not sure is there any real
> >   improvment or help after the fix.
> 
> In this case I would prefer to not implicitly follow the checkpatch.pl without
> understanding what the concern is.
> 
> The goal of this change is to make the __cpuid_count() macro available
> within kselftest and it does so by duplicating gcc's __cpuid_count() macro.
> 
> The macro style is not unique and you would, for example, encounter the same
> checkpatch.pl complaint if you run:
> ./scripts/checkpatch.pl -f arch/x86/kernel/fpu/xstate.h
  Ok, no question from my side.

  Thanks!
  --Pengfei
> 
> Reinette
