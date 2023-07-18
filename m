Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD47E757900
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 12:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjGRKKk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 06:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjGRKKj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 06:10:39 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9467AC;
        Tue, 18 Jul 2023 03:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689675038; x=1721211038;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=X/RRuyAetnm+uR/pDnhkNQZeMBAEYZMSaoXG2VCqaP4=;
  b=DU/gcDIXTt1nbAiSwdnE0ajTy+QRmdh2hs2NaT000ZmyxfB1FfLRRwse
   JM/yQ/LWPfR2Ctmq8tcHQ53l9EvW10YNIRXd6WMoypSTXdD5CVB8t+ooN
   pTzFIi6wCSAtUUp3Og4FFvqy4I22ncJkyeLUBEMKK8WFvbwF8mRCz5Mlg
   8BKqyJDEewnE9YpWySDx1lMFM3wreKLXIc/RlMhkatVURjG3TTRU1VBOF
   7pTxtFeQr+iwxoe8MojV65LHd8X3aAJdt+DvZFWYujzDanZsXVIwON8Zf
   OvXkJoqV6d2fcg7Qhq+eKwqQITzUOxy67EvLqaPr4awmd3//UfvTZKrhB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="356109417"
X-IronPort-AV: E=Sophos;i="6.01,213,1684825200"; 
   d="scan'208";a="356109417"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 03:10:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="726891956"
X-IronPort-AV: E=Sophos;i="6.01,213,1684825200"; 
   d="scan'208";a="726891956"
Received: from ijarvine-mobl2.ger.corp.intel.com ([10.252.47.53])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 03:10:35 -0700
Date:   Tue, 18 Jul 2023 13:10:34 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 10/19] selftests/resctrl: Express span internally in
 bytes
In-Reply-To: <b6bb651a-aa2a-0179-4976-5656fa446a8e@intel.com>
Message-ID: <ac83ece-bfc3-74c9-721f-e377a581bd6a@linux.intel.com>
References: <20230713131932.133258-1-ilpo.jarvinen@linux.intel.com> <20230713131932.133258-11-ilpo.jarvinen@linux.intel.com> <1dd10447-b03d-937a-fe55-ff324864c358@intel.com> <0c94daef-3642-9e8e-0e8a-3f8eaa2953e3@intel.com> <fce81fed-592e-16ad-b833-735a7b3a186@linux.intel.com>
 <f1233835-8c94-e110-531f-13712569b7c0@intel.com> <7eef29f6-297b-bb2b-e0d-ccef1aa2f14@linux.intel.com> <b6bb651a-aa2a-0179-4976-5656fa446a8e@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1402979010-1689674760=:1611"
Content-ID: <3f602b41-ec78-4198-fb50-67ba13db8385@linux.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1402979010-1689674760=:1611
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <fa67fc9f-e8b9-ac0-e3f4-8213e5ebd124@linux.intel.com>

On Mon, 17 Jul 2023, Reinette Chatre wrote:
> On 7/17/2023 5:30 AM, Ilpo Järvinen wrote:
> > On Fri, 14 Jul 2023, Reinette Chatre wrote:
> >> On 7/14/2023 3:22 AM, Ilpo Järvinen wrote:
> >>> On Fri, 14 Jul 2023, Wieczor-Retman, Maciej wrote:
> >>>> On 14.07.2023 01:00, Reinette Chatre wrote:
> >>>>> Hi Ilpo,
> >>>>>
> >>>>> On 7/13/2023 6:19 AM, Ilpo Järvinen wrote:
> >>>>>> MBA and MBM tests to use megabytes to represent span. CMT test uses
> >>>>>> bytes. The difference requires run_benchmark() to size the buffer
> >>>>>> differently based on the test name, which in turn requires passing the
> >>>>>> test name into run_benchmark().
> >>>>>>
> >>>>>> Convert MBA and MBM tests to use internally bytes like CMT test to
> >>>>>> remove the internal inconsistency between the tests. Remove the test
> >>>>>> dependent buffer sizing from run_benchmark().
> >>>>>
> >>>>> If I understand correctly the intention is to always use bytes internally
> >>>>> and only convert to megabytes when displayed to user space. The above
> >>>>> implies that this takes care of the conversion but there still seems
> >>>>> to be places that that do not follow my understanding. For example,
> >>>>> resctrl_val.c:measure_vals() converts to megabytes before proceeding.
> >>>>
> >>>> Doesn't the use case inside resctrl_val.c:measure_vals() satisfy
> >>>> the idea of only displaying data to the user space? From my
> >>>> understanding it reads the number of bytes and only converts to
> >>>> MB when printing the value. Or did I miss some detail there?
> >>>
> >>> It's for printing there yes.
> >>>
> >>> But it's not about span in the first place so I'm not sure why it is 
> >>> related.
> >>>
> >>
> >> If this change is just about how "span" is interpreted by the different
> >> tests then the changelog could be more specific to not create expectation
> >> that with this change there are no longer "bytes vs megabytes" internal
> >> inconsistency between MBA, MBM, and CMT tests.
> > 
> > The shortlog and changelog are already pretty specific in mentioning 
> > "span" a few times :-). I added yet another "span" into the changelog's 
> > 2nd paragraph.
> 
> There are many things to consider when reviewing a patch. There is the code
> changes in the patch itself that can be reviewed for correctness but there is
> also the review of the changelog's solution statement to review if the code
> changes in the patch accomplishes the stated solution. In one sense the review
> considers the code in the patch and in another the review considers what
> code may be missing from the patch.

Sure review can enlarge the scope, however, if I add some other things 
unrelated to span into this patch, it no longer is in the minimal form.

> I looked at the v5 changelog and I am still left with the same impression:
> The changelog claims that this change removes internal consistency between
> the tests, which it does not. Since you posted the next version before this
> discussion completed (which is not ideal) I'll respond further to that patch.
> In the end it may just be better to drop the "remove the internal inconsistency
> between the tests" claim.

I'm sorry, it was unintentional to send it like that. ...I honestly 
thought I had addressed all the concerns you had by adding yet another 
"span" (even if the scope was already pretty clear even w/o it, IMHO).

I see nowhere in the changelog mentioned that this change removes all 
internal inconsistencies between the test types. But I'm not attached to 
any particular wording, if the text is good enough for you w/o the 
internal inconsistency wording, I can cut that out.


-- 
 i.
--8323329-1402979010-1689674760=:1611--
