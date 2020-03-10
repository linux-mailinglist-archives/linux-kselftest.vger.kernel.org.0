Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDF85180B59
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Mar 2020 23:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbgCJWTC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Mar 2020 18:19:02 -0400
Received: from mga03.intel.com ([134.134.136.65]:3387 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbgCJWTC (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Mar 2020 18:19:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 15:19:01 -0700
X-IronPort-AV: E=Sophos;i="5.70,538,1574150400"; 
   d="scan'208";a="242472808"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.251.10.135]) ([10.251.10.135])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 10 Mar 2020 15:19:01 -0700
Subject: Re: [PATCH V1 12/13] selftests/resctrl: Dynamically select buffer
 size for CAT test
To:     Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        tony.luck@intel.com, babu.moger@amd.com, james.morse@arm.com,
        ravi.v.shankar@intel.com, fenghua.yu@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1583657204.git.sai.praneeth.prakhya@intel.com>
 <18ab8b47d1d2b6373d7899bdf8df19fa94afcfaa.1583657204.git.sai.praneeth.prakhya@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <50e8e1a1-f7ef-2ea8-178e-49adf3373e23@intel.com>
Date:   Tue, 10 Mar 2020 15:19:00 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <18ab8b47d1d2b6373d7899bdf8df19fa94afcfaa.1583657204.git.sai.praneeth.prakhya@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Sai,

On 3/6/2020 7:40 PM, Sai Praneeth Prakhya wrote:
> Presently, while running CAT test case, if user hasn't given any input for
> '-n' option, the test defaults to 5 bits to determine the buffer size that
> is used during test. Instead of statically running always with 5 bits,
> change it such that the buffer size is always half of the cache size.

This seems more appropriate as a preparation patch to not have to make
so many changes on top of the earlier patches included in this series.

Reinette
