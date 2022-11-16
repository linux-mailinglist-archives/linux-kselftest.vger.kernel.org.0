Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2910162CEBA
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Nov 2022 00:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbiKPXbR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Nov 2022 18:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbiKPXbP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Nov 2022 18:31:15 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16B75B5AC;
        Wed, 16 Nov 2022 15:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668641474; x=1700177474;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kcF8I+Kpj7C4lbmuT+ZZZAwyB2mGFnhppufCZemkF+c=;
  b=gvZv8XLelXJxxTjJcvIU4UuxjNbMxn+cfHxVYEyBY9JbhTFc5rD6YDiy
   qLrNDMSbGCqK7wc0DfqxPN0JUG2gQjha+wfHzVWWgxhSQFQ9jTJePWNo3
   em23MrXIk7FHuNxDPeGAouPuvTBRu2Dy3OHa78NwOj2atuI+zHt+jKDfG
   UwxOdNW94nZhCkMOWk/xXYEBu9ouuu6qa0Q//Qxu5UYxX2JxXyceagzUe
   fXwMA52CwafRJEce58NPp+6bQX3azO8cjTEYHcWv6OnArny86jZzyu//Z
   a2wVIj2mSj4F7FNVq7UDSRQMOh6dU/ahIVb+9xcdpbQ7ARESzYaMTbbWk
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="292404012"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="292404012"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 15:31:14 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="745267324"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="745267324"
Received: from aagbadea-mobl.amr.corp.intel.com (HELO [10.252.138.56]) ([10.252.138.56])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 15:31:13 -0800
Message-ID: <773a9deb-b017-20e5-cebe-d9c35ac4fd3d@intel.com>
Date:   Wed, 16 Nov 2022 15:31:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v7 0/6] x86/fpu: Allow PKRU to be (once again) written by
 ptrace
Content-Language: en-US
To:     Kyle Huey <me@kylehuey.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Robert O'Callahan <robert@ocallahan.org>,
        David Manouchehri <david.manouchehri@riseup.net>
References: <20221115230932.7126-1-khuey@kylehuey.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20221115230932.7126-1-khuey@kylehuey.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/15/22 15:09, Kyle Huey wrote:
> Following last week's discussion I've reorganized this patch. The goal
> remains to restore the pre-5.14 behavior of ptrace(PTRACE_SET_REGSET,
> NT_X86_XSTATE) for the PKRU register (which was equivalent to a hardware
> XRSTOR instruction).

The new version looks great.  I've applied it.

I did remove the stable@ tags for now.  There were a couple reasons for
that.  First, most of the x86 stuff marked for stable@ goes via our
tip/urgent branch and this doesn't seem super urgent.  It also touches
code that's exposed in at least three separate UABIs, so I want a bit
more soak time than x86/urgent normally provides.

I have zero objections if anyone wants to submit it to stable@ after it
hits Linus's tree.
