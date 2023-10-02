Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757587B51B1
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Oct 2023 13:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236599AbjJBLuZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Oct 2023 07:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236786AbjJBLb0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Oct 2023 07:31:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA33CD8;
        Mon,  2 Oct 2023 04:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696246283; x=1727782283;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=aCTNRtcJs2aRsXatRFnEc0X1XOXxvpcVCPYjfzR4Hds=;
  b=SGfOxKMjrYXZUJCXWbRioYOHY2UcBPNkQo1uMwBJn/7mY3zZzSnUDhmb
   BM+RvCQGRAx5yd7+w4TZcFP+gmus8VtBqXBJPDHllK9o4hx88S9tz9rEC
   QA6yrsf0OGIMmFibve9L+uu4kuV+B6NuitUUfICzurf52eNn43SzMx7ll
   XW8JVVepxZuYgC+tu36PLiCm6cuN3zg31ELIrQO3lRWmot5mKjiPwbX+W
   0tKrEvvYsH5/4JoE7YV1wHfrygTgxmkqtnweicbpgFsDUARfnOUiPl5mU
   6VWi8FVorCaeSSpc1f5OzicxZspfJbVSn0Hb+NovmonH+brMj966jWvkO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="382529557"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="382529557"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 04:31:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="866474806"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="866474806"
Received: from roliveir-mobl1.ger.corp.intel.com ([10.251.222.16])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 04:31:20 -0700
Date:   Mon, 2 Oct 2023 14:31:18 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Shuah Khan <shuah@kernel.org>
cc:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v4 0/7] selftests/resctrl: Fixes to failing tests
In-Reply-To: <20231002094813.6633-1-ilpo.jarvinen@linux.intel.com>
Message-ID: <6a826da8-a94d-261b-cfe8-c494d7237a0@linux.intel.com>
References: <20231002094813.6633-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-198948541-1696246282=:2459"
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

--8323329-198948541-1696246282=:2459
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 2 Oct 2023, Ilpo Järvinen wrote:

> Fix four issues with resctrl selftests.
> 
> The signal handling fix became necessary after the mount/umount fixes
> and the uninitialized member bug was discovered during the review.
> 
> The other two came up when I ran resctrl selftests across the server
> fleet in our lab to validate the upcoming CAT test rewrite (the rewrite
> is not part of this series).
> 
> These are developed and should apply cleanly at least on top the
> benchmark cleanup series (might apply cleanly also w/o the benchmark
> series, I didn't test).

LKP seems to no longer happy to apply this cleanly without the benchmark 
rework series as the signal handling fix got now a bigger footprint 
(maybe LKP didn't build v3 at all as the changes from v3->v4 were really 
small and I did not get error out of v3).

Shuah, would you want me to reorganize this such that it goes in before 
the benchmark series? In any case, I'll wait until Reinette has had time 
to look at the first patch if I'm to send the series reordered.


-- 
 i.

--8323329-198948541-1696246282=:2459--
