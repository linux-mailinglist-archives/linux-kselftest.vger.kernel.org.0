Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88DF2741DB9
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Jun 2023 03:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbjF2BiZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 21:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjF2BiY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 21:38:24 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D53199B
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Jun 2023 18:38:22 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b8054180acso1560805ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Jun 2023 18:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688002702; x=1690594702;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oTkD0d6a9ryiTvtazmiArPDTMy644oSqj+e8VQliv+Y=;
        b=KpJvJ8jTi0MYXdSPmYdS2cWuT55tn80Cox9G2xRB90uAn5H8xsr6sSgb2Jo1YcreBT
         lPxMFbCj5knzwuvCX4HsvoU27uF8PumefIrT7pgGEc7TuZmDZthy8YejthW5JotaZ8j1
         YIJ+m7XpeHokGhV/X8hi4HCVO38ZFYbLHr3aCYcrWcvq+lv+//ZUp4jnoZgJITetIuf/
         5KtwK8enoBIZNPm80Rozgwc91uqpnR7whP+cppW8ZGEt6rH7egLHPp56RShF1aPkiBS/
         xrcv6xhcH6TOnOOrBWQr1GBrII1Z9qItEF9ajAQpmaIQP74D5uQDTj6gcTPYZyAs15te
         7MgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688002702; x=1690594702;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oTkD0d6a9ryiTvtazmiArPDTMy644oSqj+e8VQliv+Y=;
        b=Bs1L+gXmRPoJNiINqxRHclbyqL5kmnAKUzHHUwNSjo2uucGw7vFLx5hjnVGxrMtx2N
         02RyTsK4HUNKHIqGooZ1tTESEQMa8daNE3uCja2YTIZ4j5lzT+932e3zwgUV/67qgTi+
         +J/b9YKZs6ikGVjoFbiMEnNCQj7r1cwjTmmeZxF0qNgcFO2n6k7dEfUVXmM+sxHRIdvt
         oKmT0Vg+pN21XSqsLnRgzkX6JhE6ioUuUFBwsXaTsOR4tWEohBy3YNhs7uFMqqYfiC9K
         VEBd+w8G3AordPqKrTlC03km1azI/niTrk6J+czlNINWB8SZJW4gu14o37bG5GSKP8wY
         x2rQ==
X-Gm-Message-State: AC+VfDzsvcmgZbaNxTHIsC3B5Ou+YGg7WsUrUbYrxdPNz93OZp+sdhrm
        BP/Sx/lco5IlmDJeXOdocql/Cg==
X-Google-Smtp-Source: ACHHUZ4vNfduTE+k0DVsS2q3rr0HoQZvJdXf5nxbxIoAWfAIpvWokoxLXXHfyfVQ9d7RUkGEoHJiPQ==
X-Received: by 2002:a17:903:22cf:b0:1b8:16c7:a786 with SMTP id y15-20020a17090322cf00b001b816c7a786mr9241423plg.4.1688002702392;
        Wed, 28 Jun 2023 18:38:22 -0700 (PDT)
Received: from ghost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902e98400b001b53029fef1sm2145668plb.172.2023.06.28.18.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 18:38:21 -0700 (PDT)
Date:   Wed, 28 Jun 2023 18:38:19 -0700
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     Anup Patel <anup@brainfault.org>
Cc:     Jessica Clarke <jrtc27@jrtc27.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Atish Patra <atishp@rivosinc.com>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>, bjorn@rivosinc.com,
        Evan Green <evan@rivosinc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/2] RISC-V: mm: Restrict address space for sv39,sv48,sv57
Message-ID: <ZJzgi8RyqG3Mjt0R@ghost>
References: <20230627222152.177716-1-charlie@rivosinc.com>
 <20230627222152.177716-2-charlie@rivosinc.com>
 <473F7474-D7AA-4C9F-95A3-320F1741EC50@jrtc27.com>
 <ZJtzEn9Yut3nPuw8@ghost>
 <CAAhSdy2MVu986VUUVTaY6K+s75-MpDoQvsi_jOVZWrCZq8WE2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhSdy2MVu986VUUVTaY6K+s75-MpDoQvsi_jOVZWrCZq8WE2g@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jun 28, 2023 at 06:04:41PM +0530, Anup Patel wrote:
> On Wed, Jun 28, 2023 at 5:09 AM Charlie Jenkins <charlie@rivosinc.com> wrote:
> >
> > Yes it is small to have a default of 38-bits of userspace. I would be
> > interesting in the opinions of other people on whether it would be
> > acceptable to have the default be sv48 and require applications that
> > prefer fewer bits to specify so with the given mmap hinting.
> 
> I think sv48 is a reasonable default instead of sv39. We should fallback
> to sv39 only if the underlying host does not support sv48.
> 
> Regards,
> Anup

I did some research and it appears that Java does work on sv48, but not
on sv57. Using the v6.4 kernel I was able to successfully run OpenJDK on
both sv38 and sv48, but on sv57 there is a SIGSEGV error on QEMU.
Relevant JDK discussion can be seen here 
https://mail.openjdk.org/pipermail/hotspot-dev/2022-November/067298.html.
Go similarly appears to work even on sv57 according to https://go-review.googlesource.com/c/go/+/409055.
I have not tried Go myself. 

The point of contention here I believe is that in v6.4, the highest
address space available will be used, causing all of these applications
that do not work properly in sv57 to fail when testing in sv57
environments. Given that these applications seem to work in sv48, it
seems reasonable to default to sv48, unless there are an abundance of
additional applications that are unhappy with this.

Using the hint mechanism to mmap will then allow users to change the
address space to sv57 if required. It should be possible to allow users
to use sv38 if they need it using the same mechanism, but reducing the
address space instead of growing it will require more thought from me to
implement.

Thanks,
Charlie
