Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9D277DA7E
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Aug 2023 08:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242023AbjHPGdA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Aug 2023 02:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242062AbjHPGcd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Aug 2023 02:32:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1441BF8;
        Tue, 15 Aug 2023 23:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692167552; x=1723703552;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=ZDPmeYrMaXMu6/13j5mQ5fIZnvYVckh6htfiRlsnx+k=;
  b=TJPD0xIPII21sEiG6AbnmaPyCgXsIcxZ6OiyRV3LeX6h4Ft8e5+F5nZ5
   xaBK1SJ9dbnjOeVUCThSbGatvLWFjCNIosGmmoXnLSmg1aaz/gKvvFabg
   9T9L0wcUcWFsYDKehx2M1eDLH41gsdzPRjP4yxuX7KTBxR6VH+Y+4Eb8H
   +lFz+SAM3fTSvuE36TEoYU7s4QlexoP7b2qwPYLDKvMk07kKRrkxoQdO+
   /huRsSMi1pALlTPhDXFjw8KtJwWUCi0leazf70aeTf2BFLYSOkEi2E2rT
   0X14ewVEvqG9+Big/XPJGqAoaomFi6aZ9kMO2j+n5WalGMP7hXqbYuXlG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="352781939"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="352781939"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 23:32:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="737175905"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="737175905"
Received: from ilivshiz-mobl.ger.corp.intel.com ([10.251.211.105])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 23:32:30 -0700
Date:   Wed, 16 Aug 2023 09:32:22 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Subject: Re: [PATCH 1/7] selftests/resctrl: Ensure the benchmark commands
 fits to its array
In-Reply-To: <a64114de-0a95-4ed8-aa06-b30a948fee6c@intel.com>
Message-ID: <ff136876-449-2d6a-b4dd-13ece5f3e12@linux.intel.com>
References: <20230808091625.12760-1-ilpo.jarvinen@linux.intel.com> <20230808091625.12760-2-ilpo.jarvinen@linux.intel.com> <9e56779c-4df0-654f-08e1-b27e0dd6b2ac@intel.com> <12ce6b7a-292c-6f27-809e-a7cbb810f596@linux.intel.com>
 <a64114de-0a95-4ed8-aa06-b30a948fee6c@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-574612940-1692167079=:1780"
Content-ID: <f5d7949-d8c-b283-91fb-b0fbaf8de9b@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-574612940-1692167079=:1780
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <732a985-dfec-39b3-b879-e614f8ab52ed@linux.intel.com>

On Tue, 15 Aug 2023, Reinette Chatre wrote:
> On 8/15/2023 2:10 AM, Ilpo Järvinen wrote:
> >> ps. Unless you have an updated email address that works, could you please
> >> remove Sai's email from future submissions?
> > 
> > It's auto-added by git send-email machinery. I guess I can try to make 
> > an exception to my usual workflow by sending only to manually specified To 
> > addresses (if I remember). Perhaps one day I'll write a tool to filter out
> > the addresses from git send-email generated ones but as is I don't have 
> > one.
> > 
> 
> Which git send-email machinery are you referring to? If I understand correctly
> it does not automatically pick addresses but you can provide custom commands to
> it that can do it.

Ah sorry, it is actually scripts/get_maintainer.pl automation I use with 
git send-email to figure out where to send the patches besides the --to & 
--cc entries I provided. For this patch, get_maintainer.pl returns this 
list:

Fenghua Yu <fenghua.yu@intel.com> (supporter:RDT - RESOURCE ALLOCATION,blamed_fixes:1/1=100%)
Reinette Chatre <reinette.chatre@intel.com> (supporter:RDT - RESOURCE ALLOCATION)
Shuah Khan <shuah@kernel.org> (maintainer:KERNEL SELFTEST FRAMEWORK,blamed_fixes:1/1=100%)
Babu Moger <babu.moger@amd.com> (blamed_fixes:1/1=100%)
Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com> (blamed_fixes:1/1=100%)
linux-kernel@vger.kernel.org (open list:RDT - RESOURCE ALLOCATION)
linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)

...which includes Sai's address (not much I can do about that, it's 
immutably crafted into git history that those lines were once touched by 
Sai). I've thought of writing yet another wrapper to filter out known 
failing addresses but until that's done, either I need to (remember to) 
manually send the series w/o get_maintainer.pl automation or accept a few 
failures here and there.

-- 
 i.
--8323329-574612940-1692167079=:1780--
