Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6EE87E37EF
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Nov 2023 10:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbjKGJdx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Nov 2023 04:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjKGJdw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Nov 2023 04:33:52 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2C710A;
        Tue,  7 Nov 2023 01:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699349629; x=1730885629;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=HD+xhbXA3RArZTDKEIxJ27T8R5ZBDZSHAAH/cebZ7DQ=;
  b=nZaMC9R5JJCghRNxBdsNOLhwROH6U0lN2BCcM0P1kB/04hOYBPcakh25
   VMkjmhqAdJV8tRhO+K7RvBSAHzUoOzNfjOf0nIUaWJ/1yZxtR5BRgwQVi
   aQU2Pe6qFS0QZPcvuyuiUS4eadonNqvXeGA8ziyqvWWKrXZ8F/Y7eVrf8
   DwPwDIRXVB36868LXlsnbKNl84r62L4E3K0raBGWQMTMqJyuNYOqJwkjb
   KDlOIyROWrGpytSqOb8JDx5M1wZ1WysLDFO1Gv89hkCn7/gms1KxSfHH0
   gR9bHJYS3fjQgZ3xXniRZ8NKGx/TmEBFGINH6XbglGcwVHB4HdZGwfnW5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="392344136"
X-IronPort-AV: E=Sophos;i="6.03,283,1694761200"; 
   d="scan'208";a="392344136"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 01:33:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="712508902"
X-IronPort-AV: E=Sophos;i="6.03,283,1694761200"; 
   d="scan'208";a="712508902"
Received: from pathanas-mobl1.ger.corp.intel.com ([10.252.37.194])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 01:33:46 -0800
Date:   Tue, 7 Nov 2023 11:33:40 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 23/24] selftests/resctrl: Add L2 CAT test
In-Reply-To: <af68ec80-7511-4861-b4ec-0fb9c7284513@intel.com>
Message-ID: <d3dc1393-f51d-1fea-2787-4063abdc7c33@linux.intel.com>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com> <20231024092634.7122-24-ilpo.jarvinen@linux.intel.com> <8051f3ef-1126-41fb-b6cc-f48441936dd7@intel.com> <2514e73e-2419-7c88-3f22-469db4b2fa25@linux.intel.com> <48c6795b-554a-4019-bb8d-a2ca0f6fbb2b@intel.com>
 <4008929-d12b-793e-dce8-eb5ba03b4ebb@linux.intel.com> <755ed028-f73a-47ed-a58a-65f4f48eaee3@intel.com> <af68ec80-7511-4861-b4ec-0fb9c7284513@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1825553086-1699349628=:1851"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1825553086-1699349628=:1851
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 6 Nov 2023, Reinette Chatre wrote:
> On 11/6/2023 9:03 AM, Reinette Chatre wrote:
> > On 11/6/2023 1:53 AM, Ilpo Järvinen wrote:
> >> On Fri, 3 Nov 2023, Reinette Chatre wrote:
> >>> On 11/3/2023 3:39 AM, Ilpo Järvinen wrote:
> >>>> On Thu, 2 Nov 2023, Reinette Chatre wrote:
> >>>>> On 10/24/2023 2:26 AM, Ilpo Järvinen wrote:
> >>>>
> >>>>>> Add L2 CAT selftest. As measuring L2 misses is not easily available
> >>>>>> with perf, use L3 accesses as a proxy for L2 CAT working or not.
> >>>>>
> >>>>> I understand the exact measurement is not available but I do notice some
> >>>>> L2 related symbolic counters when I run "perf list". l2_rqsts.all_demand_miss
> >>>>> looks promising.
> >>>>
> >>>> Okay, I was under impression that L2 misses are not available. Both based 
> >>>> on what you mentioned to me half an year ago and because of what flags I 
> >>>> found from the header. But I'll take another look into it.
> >>>
> >>> You are correct that when I did L2 testing a long time ago I used
> >>> the model specific L2 miss counts. I was hoping that things have improved
> >>> so that model specific counters are not needed, as you have tried here.
> >>> I found the l2_rqsts symbol while looking for alternatives but I am not
> >>> familiar enough with perf to know how these symbolic names are mapped.
> >>> I was hoping that they could be a simple drop-in replacement to
> >>> experiment with.
> >>
> >> According to perf_event_open() manpage, mapping those symbolic names 
> >> requires libpfm so this would add a library dependency?
> > 
> > I do not see perf list using this library to determine the event and
> > umask but I am in unfamiliar territory. I'll have to spend some more
> > time here to determine options.
> 
> tools/perf/pmu-events/README cleared it up for me. The architecture specific
> tables are included in the perf binary. Potentially pmu-events.h could be
> included or the test could just stick with the architectural events.
> A quick look at the various cache.json files created the impression that
> the events of interest may actually have the same event code and umask across
> platforms.
> I am not familiar with libpfm. This can surely be considered if it supports
> this testing. Several selftests have library dependencies.

man perf_event_open() says this:

"If type is PERF_TYPE_RAW, then a custom "raw" config  value  is  needed.
Most  CPUs  support  events  that  are  not covered by the "generalized"
events.  These are implementation defined; see your CPU manual (for  ex-
ample  the  Intel Volume 3B documentation or the AMD BIOS and Kernel De-
veloper Guide).  The libpfm4 library can be used to translate  from  the
name in the architectural manuals to the raw hex value perf_event_open()
expects in this field."

...I've not come across libpfm myself either but to me it looks libpfm 
bridges between those architecture specific tables and perf_event_open(). 
That is, it could provide the binary value necessary in constructing the 
perf_event_attr struct.

I think this is probably the function which maps string -> 
perf_event_attr:

https://man7.org/linux/man-pages/man3/pfm_get_os_event_encoding.3.html


-- 
 i.

--8323329-1825553086-1699349628=:1851--
