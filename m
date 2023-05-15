Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8214B702FB4
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 May 2023 16:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240415AbjEOO2c (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 May 2023 10:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbjEOO2b (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 May 2023 10:28:31 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B4E135;
        Mon, 15 May 2023 07:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684160910; x=1715696910;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xfYqN7JzCkoWyoq5r778vSA22m35h9Rh/Z7ivVg+D70=;
  b=MgJzIN65On4PRivQcdUiaKv9uI/ANGlIdE1FenyRi2tmeqLONzMYQS9p
   R7082gQymCIssLyq1uuKBqh/KwOb5RIfBAICi4XJqRWTY1g9A2VOQiPti
   uPXjydQ8/hu1EjraE3SlR6cOxwu2HyhGt9EyTo048mKFSV7o0eBKTAuSi
   CCf4/agoo8hqHFGiTrZtj6pZd1p2XhtMpIeg9pB1wMFlgC9ZFVHKXbsXr
   c8X0s8j3ciQPhq4lAUqrq9PGJSMnllrLqc01xCNzjtjvFGbz9D4JfWVUj
   whM2n/+HPK06qNWfjiMoGr4+IqA9r4Pffm7Ie2jQflL3nkRca5XFnjrj0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="354372400"
X-IronPort-AV: E=Sophos;i="5.99,276,1677571200"; 
   d="scan'208";a="354372400"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 07:28:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="733897472"
X-IronPort-AV: E=Sophos;i="5.99,276,1677571200"; 
   d="scan'208";a="733897472"
Received: from satwikja-mobl.amr.corp.intel.com (HELO [10.212.213.112]) ([10.212.213.112])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 07:28:30 -0700
Message-ID: <2bcffc9f-9244-0362-2da9-ece230055320@intel.com>
Date:   Mon, 15 May 2023 07:28:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/6] Memory Mapping (VMA) protection using PKU - set 1
Content-Language: en-US
To:     jeffxu@chromium.org, luto@kernel.org, jorgelo@chromium.org,
        keescook@chromium.org, groeck@chromium.org, jannh@google.com,
        sroettger@google.com
Cc:     akpm@linux-foundation.org, jeffxu@google.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
References: <20230515130553.2311248-1-jeffxu@chromium.org>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230515130553.2311248-1-jeffxu@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/15/23 06:05, jeffxu@chromium.org wrote:
> We're using PKU for in-process isolation to enforce control-flow integrity
> for a JIT compiler. In our threat model, an attacker exploits a 
> vulnerability and has arbitrary read/write access to the whole process
> space concurrently to other threads being executed. This attacker can
> manipulate some arguments to syscalls from some threads.

This all sounds like it hinges on the contents of PKRU in the attacker
thread.

Could you talk a bit about how the attacker is prevented from running
WRPKRU, XRSTOR or compelling the kernel to write to PKRU like at sigreturn?
