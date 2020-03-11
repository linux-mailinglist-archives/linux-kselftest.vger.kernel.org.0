Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 268B8180E41
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Mar 2020 03:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbgCKC5q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Mar 2020 22:57:46 -0400
Received: from mga18.intel.com ([134.134.136.126]:25558 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727307AbgCKC5q (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Mar 2020 22:57:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 19:57:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,539,1574150400"; 
   d="scan'208";a="231544522"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
  by orsmga007.jf.intel.com with ESMTP; 10 Mar 2020 19:57:44 -0700
Message-ID: <48e14e976d3258571229d3165aa879da4a6e4b28.camel@intel.com>
Subject: Re: [PATCH V1 12/13] selftests/resctrl: Dynamically select buffer
 size for CAT test
From:   Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        tony.luck@intel.com, babu.moger@amd.com, james.morse@arm.com,
        ravi.v.shankar@intel.com, fenghua.yu@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 10 Mar 2020 19:52:57 -0700
In-Reply-To: <50e8e1a1-f7ef-2ea8-178e-49adf3373e23@intel.com>
References: <cover.1583657204.git.sai.praneeth.prakhya@intel.com>
         <18ab8b47d1d2b6373d7899bdf8df19fa94afcfaa.1583657204.git.sai.praneeth.prakhya@intel.com>
         <50e8e1a1-f7ef-2ea8-178e-49adf3373e23@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Reinette,

On Tue, 2020-03-10 at 15:19 -0700, Reinette Chatre wrote:
> Hi Sai,
> 
> On 3/6/2020 7:40 PM, Sai Praneeth Prakhya wrote:
> > Presently, while running CAT test case, if user hasn't given any input for
> > '-n' option, the test defaults to 5 bits to determine the buffer size that
> > is used during test. Instead of statically running always with 5 bits,
> > change it such that the buffer size is always half of the cache size.
> 
> This seems more appropriate as a preparation patch to not have to make
> so many changes on top of the earlier patches included in this series.

Ok.. makes sense.

Regards,
Sai

