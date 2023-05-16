Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1E3705B4D
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 01:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbjEPXYM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 May 2023 19:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbjEPXYK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 May 2023 19:24:10 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D39C5594;
        Tue, 16 May 2023 16:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684279436; x=1715815436;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wgM7eIPJSPaebudw9GLyN8QMt1bMjOZTH6XelPWKDrY=;
  b=DRuSSoVKQ6tj8AilLJa7PZEvhKNbQS2iyBydyeG0lb/joyBxxu0HhTf1
   p5RV0U49fu30J4QS+w0eWfhSyfjJBLyddmz8Zr51muXgPzbH9Rv62cqXw
   xvqv0e7ipVC79W7vz2Ul680/qexm+jOhmlgPGZKh/Z4ZyR5ipe+KrYhs3
   QNqXod3D9SHIRKRmrHgWHAJCuP36S6OLMSenKBFzvvkemw6r/rE3xGJ6M
   BMVhbOFY3hNV2QqSzkQhMa3/SmF9YkPyIuzurM1b8GACFfKXed/p31qMd
   PpaiheyH1rM3i2dBOUTp4nDmcqSBK6w/KQgxILnmCTbM94lc93JSHB1SH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="379800869"
X-IronPort-AV: E=Sophos;i="5.99,280,1677571200"; 
   d="scan'208";a="379800869"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 16:23:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="652007679"
X-IronPort-AV: E=Sophos;i="5.99,280,1677571200"; 
   d="scan'208";a="652007679"
Received: from mtpanu-mobl1.amr.corp.intel.com (HELO [10.212.203.6]) ([10.212.203.6])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 16:23:55 -0700
Message-ID: <4f14a645-3569-2e3b-f55c-3b17b567845a@intel.com>
Date:   Tue, 16 May 2023 16:23:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 5/6] KEY: Apply PKEY_ENFORCE_API to munmap
Content-Language: en-US
To:     jeffxu@chromium.org, luto@kernel.org, jorgelo@chromium.org,
        keescook@chromium.org, groeck@chromium.org, jannh@google.com,
        sroettger@google.com
Cc:     akpm@linux-foundation.org, jeffxu@google.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
References: <20230515130553.2311248-1-jeffxu@chromium.org>
 <20230515130553.2311248-6-jeffxu@chromium.org>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230515130553.2311248-6-jeffxu@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/15/23 06:05, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@google.com>
> 
> This patch enables PKEY_ENFORCE_API for the munmap
> syscall.

The basic problem here is how we know when the set of syscalls that are
patched here is good enough and how we catch future functionality that
might need to be captured as well.

This mechanism really needs to be able to defend against *any* changes
to the address space.  I assume that folks are using syscall filtering
to prevent new syscalls from causing havoc, but is there anything that
can be done for, say, things like madvise()?  I bet it was harmless for
a long time until MADV_DONTNEED showed up and made it able to
effectively zero memory.
