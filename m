Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0357562BF
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 14:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjGQMbC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 08:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjGQMbB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 08:31:01 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECAFE4F;
        Mon, 17 Jul 2023 05:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689597060; x=1721133060;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=IALTvRizVydvE6kCecPGFlOXq43R/hzRHUtn5JcSzoA=;
  b=XKhQ1Kx8mh1NpIchXVoRUS/baSzxn9RgynnBRuoptJMv41q2Woyn/aCJ
   plrUYXNJTPkKCxYYlf4z+5V/VrSDz/DZ7WN+rIaKbE+YIELDQ+09R2seo
   A86Sw5/s63/Lzwbs426fXa9VyRyPooOS/tPuPmh781fwG/PGLjwYi+R7j
   f82K7thkEdhUeupb7wUno4QuYEMRBOdIWebYwBhNt3TYJzcp/awBDi/J3
   32IjuOaNCB59p9Hc80DloWy8H4OQDYHaXAMXbdOkz42Uyh3oAfTSWQPYh
   OPCFDH81Vaa2wOgSEDuFE47LYZ3fb2Sx3AF9rCa6oCzkA83vDsa5RgSDI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="350780158"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="350780158"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 05:31:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="969869426"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="969869426"
Received: from dkravtso-mobl1.ccr.corp.intel.com ([10.252.45.233])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 05:30:57 -0700
Date:   Mon, 17 Jul 2023 15:30:52 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 10/19] selftests/resctrl: Express span internally in
 bytes
In-Reply-To: <f1233835-8c94-e110-531f-13712569b7c0@intel.com>
Message-ID: <7eef29f6-297b-bb2b-e0d-ccef1aa2f14@linux.intel.com>
References: <20230713131932.133258-1-ilpo.jarvinen@linux.intel.com> <20230713131932.133258-11-ilpo.jarvinen@linux.intel.com> <1dd10447-b03d-937a-fe55-ff324864c358@intel.com> <0c94daef-3642-9e8e-0e8a-3f8eaa2953e3@intel.com> <fce81fed-592e-16ad-b833-735a7b3a186@linux.intel.com>
 <f1233835-8c94-e110-531f-13712569b7c0@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-906854338-1689597059=:1907"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-906854338-1689597059=:1907
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 14 Jul 2023, Reinette Chatre wrote:
> On 7/14/2023 3:22 AM, Ilpo Järvinen wrote:
> > On Fri, 14 Jul 2023, Wieczor-Retman, Maciej wrote:
> >> On 14.07.2023 01:00, Reinette Chatre wrote:
> >>> Hi Ilpo,
> >>>
> >>> On 7/13/2023 6:19 AM, Ilpo Järvinen wrote:
> >>>> MBA and MBM tests to use megabytes to represent span. CMT test uses
> >>>> bytes. The difference requires run_benchmark() to size the buffer
> >>>> differently based on the test name, which in turn requires passing the
> >>>> test name into run_benchmark().
> >>>>
> >>>> Convert MBA and MBM tests to use internally bytes like CMT test to
> >>>> remove the internal inconsistency between the tests. Remove the test
> >>>> dependent buffer sizing from run_benchmark().
> >>>
> >>> If I understand correctly the intention is to always use bytes internally
> >>> and only convert to megabytes when displayed to user space. The above
> >>> implies that this takes care of the conversion but there still seems
> >>> to be places that that do not follow my understanding. For example,
> >>> resctrl_val.c:measure_vals() converts to megabytes before proceeding.
> >>
> >> Doesn't the use case inside resctrl_val.c:measure_vals() satisfy
> >> the idea of only displaying data to the user space? From my
> >> understanding it reads the number of bytes and only converts to
> >> MB when printing the value. Or did I miss some detail there?
> > 
> > It's for printing there yes.
> > 
> > But it's not about span in the first place so I'm not sure why it is 
> > related.
> > 
> 
> If this change is just about how "span" is interpreted by the different
> tests then the changelog could be more specific to not create expectation
> that with this change there are no longer "bytes vs megabytes" internal
> inconsistency between MBA, MBM, and CMT tests.

The shortlog and changelog are already pretty specific in mentioning 
"span" a few times :-). I added yet another "span" into the changelog's 
2nd paragraph.

Your general observation about the other MB/bytes inconsistency is still
a good one so I added it also to my todo list, it just doesn't belong to 
this patch (IMHO).


-- 
 i.

--8323329-906854338-1689597059=:1907--
