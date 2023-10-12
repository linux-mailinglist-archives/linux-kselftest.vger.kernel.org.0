Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA457C6EBF
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Oct 2023 15:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347272AbjJLNGa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Oct 2023 09:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343765AbjJLNG2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Oct 2023 09:06:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05886BB;
        Thu, 12 Oct 2023 06:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697115986; x=1728651986;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=GxRxI25797mAB3SvQoCXKOxK78lq69Yok/R7drs3Dvg=;
  b=F/uCecGrOyEPPrMaOv1w5je26lXlMLtVg3G8kjDgFQbMZzMMlXlI+dVj
   80esBJ+COvIVWkVzjrjT44G4XiGxUzBI/a2Z55STmk2DNjSIoff7fBT1G
   4L82CTovpZ4jH8fapoTPKfxeDLIFehEAnm55PsuGL801GU7HMBv00Ehy3
   ri2RU2AgYbrN0IaizJxebLCbAgZX5X5X6vbGIW6GHs/LkF9//PHn1rn5h
   RPEIq+9nXeoVH19Eg/tWU3WVSR7jlzYfuNHpxZfdJe2almyHXVI2KHXXJ
   gaVRtxf06UejyYyB/NaPGgiCLSBNW4UTkSe/JxYl9rySr7Da5iiKySSme
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="415960149"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="415960149"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 06:06:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="730920344"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="730920344"
Received: from asroczyn-mobl.ger.corp.intel.com ([10.249.36.107])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 06:06:24 -0700
Date:   Thu, 12 Oct 2023 16:06:21 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= 
        <maciej.wieczor-retman@intel.com>, Shuah <shuah@kernel.org>
cc:     Reinette Chatre <reinette.chatre@intel.com>,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/8] selftests: Add printf attribute to kselftest
 prints
In-Reply-To: <4h2eu6yhodrujbvem24v7cwal5tnk2agsqulpxwi4myk7n35uq@phbxlajivrpq>
Message-ID: <fe517843-8b27-99c5-99c-f4fba4f2d2@linux.intel.com>
References: <cover.1697012398.git.maciej.wieczor-retman@intel.com> <13a47130763d109aa40de153ecbee9ede22d8356.1697012398.git.maciej.wieczor-retman@intel.com> <a2a5cb05-8604-4303-9802-573359c68368@kernel.org>
 <4h2eu6yhodrujbvem24v7cwal5tnk2agsqulpxwi4myk7n35uq@phbxlajivrpq>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-292299776-1697115985=:1692"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-292299776-1697115985=:1692
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Thu, 12 Oct 2023, Maciej Wieczór-Retman wrote:

> On 2023-10-11 at 13:40:48 -0600, Shuah wrote:
> >On 10/11/23 02:23, Maciej Wieczor-Retman wrote:
> >> Kselftest header defines multiple variadic functions that use printf
> >> along with other logic.
> >> 
> >> There is no format checking for the variadic functions that use
> >> printing inside kselftest.h. Because of this the compiler won't
> >> be able to catch instances of mismatched printf formats and debugging
> >> tests might be more difficult.
> >> 
> >> Add the common __printf attribute macro to kselftest.h.
> >> 
> >> Add __printf attribute to every function using formatted printing with
> >> variadic arguments.
> >> 
> >> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> >> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> >> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> >> ---
> >> Changelog v4:
> >> - Fix typo in patch subject. (Reinette)
> >> - Add Reinette's reviewed-by tag.
> >> 
> >
> >I still need information on how you found these problems. Please
> >add it to change log for each of these patches.
> 
> Sure, I'll add notes on methodology to patches 2-8. I understand that
> this patch (1/8) message doesn't need that addition since the problems
> it exposes are in separate patches.
> 
> Or would you like me to also note here more specifically what effect it
> has in the rest of the series?
> 
> >I am seeing checkpatch warning:
> >
> >WARNING: Prefer __printf(a, b) over __attribute__((format(printf, a, b)))
> >#102: FILE: tools/testing/selftests/kselftest.h:81:
> >+#define __printf(a, b)   __attribute__((format(printf, a, b)))
> 
> Running checkpatch.pl with --show-types shows the
> PREFER_DEFINED_ATTRIBUTE_MACRO is raised. From looking at the error
> message in the script it looks like a false positive:
> 	"Prefer $new over __attribute__(($orig_attr$params))\n"
> 
> Please correct me if my train of thought is wrong but I think checkpatch
> sees __printf() macro defined and it sees it's raw version
> "__attribute__((format(printf, a, b)))" which it wants to replace with
> the macro. But since the raw version is found in the define line that is
> obviously not possible.

Yes, this is clearly a false positive from checkpatch. Checkpatch's logic 
cannot differentiate the definition from the use of __printf(), it just 
assumes __printf() is there already, which is not true for selftests.

The patch adds the capability to use __printf() elsewhere in the 
selftests code but of course the definition of __printf() itself has to 
use __attribute__().

-- 
 i.

--8323329-292299776-1697115985=:1692--
