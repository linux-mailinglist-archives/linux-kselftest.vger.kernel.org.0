Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B566695F74
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Feb 2023 10:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbjBNJlS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Feb 2023 04:41:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbjBNJlQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Feb 2023 04:41:16 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0B5EC6C;
        Tue, 14 Feb 2023 01:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676367675; x=1707903675;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=J/XmRTA5+tCPquSDDFAnVRNC8hx6+9814aW45sMaJQw=;
  b=AOVOWGbnOvQdHK0UlqSzDO4EhbeEOmg8QxwuFuL6cr3mn/isyNxNExW4
   96WHcFBx2HTAvNk096jDvr95wbFG0vKSS08lO3b1m1/0O9dEW3hhO+3PR
   VHt0wElxJ7yuLaRPEDO/xIpiqPdXiGDL6dLtUZQ7OjBdpzOkF/CS7vBwk
   Nz0coYvagv/otI5/jYbvt1zvGKclULCNfkqALqWPfUB1BB1DwKc4cEOE0
   nU7mwmbR+4xEvgGpJvDJ8XzyUpdSQwB7hCJVtJtczBcCs8d7UlxB8lUbg
   /rViWn7d7l5jxOVLMl3qFrqGOxrTG/nf6YJ0i3Yu9rxkvAn8Ch8U/Fc81
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="331120959"
X-IronPort-AV: E=Sophos;i="5.97,296,1669104000"; 
   d="scan'208";a="331120959"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 01:41:15 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="998016918"
X-IronPort-AV: E=Sophos;i="5.97,296,1669104000"; 
   d="scan'208";a="998016918"
Received: from asmit6-mobl2.ger.corp.intel.com ([10.249.37.52])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 01:41:10 -0800
Date:   Tue, 14 Feb 2023 11:41:08 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v7 4/6] selftests/resctrl: Cleanup properly when an error
 occurs in CAT test
In-Reply-To: <1a933b7c-0318-ce06-9239-197d78c9889d@intel.com>
Message-ID: <7c99dc3c-a4fe-3285-f48f-8d1a562db2fb@linux.intel.com>
References: <20230213062428.1721572-1-tan.shaopeng@jp.fujitsu.com> <20230213062428.1721572-5-tan.shaopeng@jp.fujitsu.com> <616c7fab-65ad-17b7-f360-94b7e22f892@linux.intel.com> <1a933b7c-0318-ce06-9239-197d78c9889d@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1599909318-1676367539=:1771"
Content-ID: <1723893-9b15-d040-132-c58915222e7@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1599909318-1676367539=:1771
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <80d4e2c8-9df5-8ecd-ea32-4729b7bf1acf@linux.intel.com>

On Mon, 13 Feb 2023, Reinette Chatre wrote:

> 
> 
> On 2/13/2023 2:00 AM, Ilpo Järvinen wrote:
> > On Mon, 13 Feb 2023, Shaopeng Tan wrote:
> > 
> >> After creating a child process with fork() in CAT test, if an error
> >> occurs when parent process runs cat_val() or check_results(), the child
> > 
> > I'd replace the rest of the paragraph with this:
> > 
> > "returns early. The parent will wait pipe message from child which will 
> > never be sent by the child and the parent cannot proceeed to unmount 
> > resctrlfs."
> 
> Note that the description is about an error within the parent process.
> In the case snipped above it is the parent that exits early, not the child.

Ah, that a good point. Somehow I was too fixed into thinking the child 
exiting because it's what it's come across myself.

-- 
 i.

> This first paragraph describes two scenarios, (a) error in parent, and (b)
> error in child. I think it is good information to keep descriptions of
> both scenarios.
> 
> The proposed addition could be used to expand the description of the scenario
> when an error occurs in the child. In this case please consider changing "wait
> pipe message from child" to "wait for the pipe message from the child", and
> "proceeed" to "proceed".
> 
> Reinette
> 
--8323329-1599909318-1676367539=:1771--
