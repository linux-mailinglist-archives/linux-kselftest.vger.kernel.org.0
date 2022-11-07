Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C020261FFDC
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Nov 2022 21:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbiKGUw5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 15:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbiKGUw4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 15:52:56 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FF727176;
        Mon,  7 Nov 2022 12:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667854375; x=1699390375;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KHZYJ5N4WN4GFIdBJV+9/tjtDA1oPGVdqK3Z+qwe07A=;
  b=Oc4iLPbTPMczUwq7su4EZeOzYvn7LuUMbqbYNqEXUcgvB4MtvkFwdXwW
   qEnvnxPAnDC1MJdQfKAYy3pd0oehrgS8oGaLNA+OqsGmX1cD2alChzFWV
   215PZQEPr/YEPL591QgUcgP0OU4uoi1aIn0otS0l6x8yT41L8sdeEMbnX
   pd25pTFaMcjDJGTEsayNwIa9Zgz0HM7b+KzPxYvT1ycWQKJFutEgMqGi4
   BMsphX036TjjhFhf2w/9ZvlXqHXQrOSAoaIz2zhCFKv2f/7D/klK+o9yb
   Xwc8u1NP08ha4yaPADeMX9fCzXxJJ376BiZYmZpjz6DEMnvtqrmhM51fk
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="310524040"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="310524040"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 12:52:55 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="699636618"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="699636618"
Received: from peggykes-mobl.amr.corp.intel.com (HELO [10.251.7.244]) ([10.251.7.244])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 12:52:54 -0800
Message-ID: <6d29eadd-69ef-343d-fcc8-b0432d604e92@intel.com>
Date:   Mon, 7 Nov 2022 12:52:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RESEND PATCH v6] x86/fpu: Trying to fix writing PKRU through
 ptrace
Content-Language: en-US
To:     Slade Watkins <srw@sladewatkins.net>, Kyle Huey <me@kylehuey.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
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
References: <20221107063807.81774-1-khuey@kylehuey.com>
 <CA+pv=HNPDvr_SV0f6RSBz2A3qBQQLBXaaxTPPT4FABQhwQwuHw@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CA+pv=HNPDvr_SV0f6RSBz2A3qBQQLBXaaxTPPT4FABQhwQwuHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/7/22 12:49, Slade Watkins wrote:
> On Mon, Nov 7, 2022 at 1:38 AM Kyle Huey <me@kylehuey.com> wrote:
>> I've been trying since July to get this regression that was introduced in
>> 5.14 fixed. This is my third time submitting this version of the patch in the
>> last two months. Both prior submissions have not received any comments from
>> (nor have they been applied by) the x86 maintainers. I don't really know
>> what else to do at this point beyond "complain to the management" as it
>> were.
>>
>> I appreciate anything you can do to unjam things here.
> Maintainers: is there any reason why this hasn't been applied, or
> received comments? I'm confused and a bit worried.

Thomas had some strong opinions in the area, so I've been neglecting it.
 I'll put it in my queue to take a look now, though.
