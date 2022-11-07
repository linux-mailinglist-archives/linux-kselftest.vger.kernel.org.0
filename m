Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09EE261FFDE
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Nov 2022 21:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbiKGUx3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 15:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233023AbiKGUxZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 15:53:25 -0500
X-Greylist: delayed 200 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Nov 2022 12:53:23 PST
Received: from 005.lax.mailroute.net (005.lax.mailroute.net [199.89.1.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12B11000
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Nov 2022 12:53:22 -0800 (PST)
Received: from 014.lax.mailroute.net (014.lax.mailroute.net [199.89.1.17])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by 005.lax.mailroute.net (Postfix) with ESMTPS id 4N5jzG2lwbz1T5Mn
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Nov 2022 20:50:02 +0000 (UTC)
Received: from localhost (014.lax.mailroute.net [127.0.0.1])
        by 014.lax.mailroute.net (Postfix) with ESMTP id 4N5jzF6Yz1z3G0H9
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Nov 2022 20:50:01 +0000 (UTC)
X-Virus-Scanned: by MailRoute
Received: from 014.lax.mailroute.net ([199.89.1.17])
        by localhost (014.lax [127.0.0.1]) (mroute_mailscanner, port 10026)
        with LMTP id PKTZxTzS8ZRb for <linux-kselftest@vger.kernel.org>;
        Mon,  7 Nov 2022 20:50:00 +0000 (UTC)
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by 014.lax.mailroute.net (Postfix) with ESMTPS id 4N5jzD6gLMz3G02C
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Nov 2022 20:50:00 +0000 (UTC)
Received: by mail-pf1-f200.google.com with SMTP id m6-20020aa79006000000b0056bc283f477so6090501pfo.19
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Nov 2022 12:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=googled;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7C2AzLoIXAOHTIa3Ey64y5Lcd9pKKsuRkuQWS8S5h84=;
        b=EAFy6Ne/R1g5VTzYbERV/rFcUG1RncvMunzz4ZfDLEkndNaa8881m/x/wOgeArPhb8
         J3+9RZPJ7DZCR0zR5GE5SKdmHmuXmSsNRV78mzdhuv158Vfa3dJupI7cGBZKBC9UnLhN
         npNSENOVtuPiCJGBaFz+6wvkF9cZXdQ1h6hY9v6AV7d6Ikyher73i7x6lf1qMvFJPskw
         kUmnYWKWvCLf9aSHHb2bIwwMpTKX2QV/+JnHWFN/VcmGCPZxhbrSj6vmGeeS09rzPsfZ
         KhWmZXtsDF0ASL4eEmRjZxzJ5IfT0A10PDkZuexcZmkmokRfjt5i19eYHEA8fO8NJHe5
         D+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7C2AzLoIXAOHTIa3Ey64y5Lcd9pKKsuRkuQWS8S5h84=;
        b=mSQ+bHDgDg6Z/08uaNwlJs+G6KOCSQzZ9wc3ny6Zl9SSpXcHLxx9u/GZsHjHWueTU8
         Il+NzqnSWZofJu7/QOJtcZ/ucF/ujLrGcKRdTNZuRL+tICuM6/uv108ORg4pQFSo3U16
         ziNZ0rEU/GXvg0jnQMvXuBu81mgZTOqrYqwJDWDkR/77ofq43ApVDpUjpHYPf9pjrMy3
         1abaB1p5cM6/zbP9hJABV11P+4iG1xvE7I7OhW8apNuxZSMsQPrGlwxvVjO3hHg1dCIu
         fDlEj0xz/hJ1vfQ4nRPhOZZRvED089B89yXRPKkh9t+eFtl2fGYohvVEvRikz/u0bnG+
         4PLw==
X-Gm-Message-State: ACrzQf0adff91hx9JGX3ZP2yNQ2AMDvNLga91n08QHcacbpn99ZBx8G+
        nnhPHJPoV22MktbYLU8cZn7n033YisUx3fBDkJp1G+THoU118VzSqYjJwiHKNsiXhVqvnwNgoeq
        tz1GeznU+bSvV68eWA6J95/5uxEY5eIhylXxZPAeqN4Bko7ybPzDRYHRCyTM=
X-Received: by 2002:a17:902:9b88:b0:188:620d:90fc with SMTP id y8-20020a1709029b8800b00188620d90fcmr22192410plp.61.1667854200193;
        Mon, 07 Nov 2022 12:50:00 -0800 (PST)
X-Google-Smtp-Source: AMsMyM7xWEFMd05xK8hyJabZq53YX527qoS3pncq2Cf2MdeoKWmeTkDLEGqQ331usKklxWYzqf9H26GDfE4z++eeLjE=
X-Received: by 2002:a17:902:9b88:b0:188:620d:90fc with SMTP id
 y8-20020a1709029b8800b00188620d90fcmr22192381plp.61.1667854199868; Mon, 07
 Nov 2022 12:49:59 -0800 (PST)
MIME-Version: 1.0
References: <20221107063807.81774-1-khuey@kylehuey.com>
In-Reply-To: <20221107063807.81774-1-khuey@kylehuey.com>
From:   Slade Watkins <srw@sladewatkins.net>
Date:   Mon, 7 Nov 2022 15:49:48 -0500
Message-ID: <CA+pv=HNPDvr_SV0f6RSBz2A3qBQQLBXaaxTPPT4FABQhwQwuHw@mail.gmail.com>
Subject: Re: [RESEND PATCH v6] x86/fpu: Trying to fix writing PKRU through ptrace
To:     Kyle Huey <me@kylehuey.com>
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
        "Robert O'Callahan" <robert@ocallahan.org>,
        David Manouchehri <david.manouchehri@riseup.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 7, 2022 at 1:38 AM Kyle Huey <me@kylehuey.com> wrote:
> I've been trying since July to get this regression that was introduced in
> 5.14 fixed. This is my third time submitting this version of the patch in the
> last two months. Both prior submissions have not received any comments from
> (nor have they been applied by) the x86 maintainers. I don't really know
> what else to do at this point beyond "complain to the management" as it
> were.
>
> I appreciate anything you can do to unjam things here.

Maintainers: is there any reason why this hasn't been applied, or
received comments? I'm confused and a bit worried.

-srw
