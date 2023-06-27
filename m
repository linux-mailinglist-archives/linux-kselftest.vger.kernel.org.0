Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C041D7406E7
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 01:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjF0XjJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Jun 2023 19:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjF0XjI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Jun 2023 19:39:08 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D26A1FE8
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Jun 2023 16:39:06 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-666ed230c81so4642815b3a.0
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Jun 2023 16:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687909145; x=1690501145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UEotHXGDYPp+N3kzq40A+VGZCyOFKrHwBcgbYar1LOg=;
        b=eYlkZ7RRnjfcOrSEl/RtfXtVIUDXY/SobZ+VOu+z+XZHDsoEHatYx90/aUQor4mUER
         wxITd49Kw7XvhgcVFYoq4mFZHL7z9aHi0r+QhYL+g6lSIMWRwtUnRedNFC3xOasfMCGu
         NMW3alJ7N94ag1BxPWU3TUclX+f/qX/0DGmvK8TotY9FNIbXV2sghgXhF1dj95yOf38/
         aHhPazCeoEJ3bjLeb0sOynGrNXxx3SbNj3Yv4MZJkno3PbCEZ90u3WQM2pmyz5GbAghI
         VTNT8URWzEYzrjzYGj1gAMAkiBLPMrE0uL/vLOppa8GJnYQW2b0d5av0daalTnL+EJTh
         10/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687909145; x=1690501145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UEotHXGDYPp+N3kzq40A+VGZCyOFKrHwBcgbYar1LOg=;
        b=QLwU3dR3ZIB7ql+x7hGiUomCwIohdCk6qU/38O0F5RV48lMLvzalzMqmt5anhqZ37V
         wdAE1MKCWuwMjVgVYxDs81ELqCFAM2e5X69ecWHJ8A5BQTEGfpqB47upKAj1+juLEAXS
         Wdn2bMTbM+W4Z9F/4sck45KRGVHSmmTJRXhmn6IMwSfN+UVni89EpL07hIJOy7hX9M1C
         bJdz9g4GyHJwHrJtdYRqTte6OuMmgbpFHv/e0obqMsRJKLnadjxNbfkxQV83yGa0Lbrx
         ALIRdPp6wupKfATnU4V8amYUtnrDCbNvUsiUTrqW+epYA5Jj8xGD0SNsshE31IhYFep7
         zhCg==
X-Gm-Message-State: AC+VfDwaxMBAgfV7+BeREIqJ+1fBZmZt9jVMagesAzu9nrd6n11NhYOh
        q/PAxtCqFwa2Txb5eJdkBM5LDQ==
X-Google-Smtp-Source: ACHHUZ5OkeSCUeB3U9dhKZWjZbN1Lvc3xdWPDUeDJ0nMM+W1gpyxhwafH7+mT55TVE586Y44vKy4GQ==
X-Received: by 2002:a05:6a20:244b:b0:12b:6898:2986 with SMTP id t11-20020a056a20244b00b0012b68982986mr3198761pzc.1.1687909145650;
        Tue, 27 Jun 2023 16:39:05 -0700 (PDT)
Received: from ghost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id fe8-20020a056a002f0800b00666912d8a52sm4748899pfb.197.2023.06.27.16.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 16:39:05 -0700 (PDT)
Date:   Tue, 27 Jun 2023 16:38:58 -0700
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     Jessica Clarke <jrtc27@jrtc27.com>
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Atish Patra <atishp@rivosinc.com>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>, bjorn@rivosinc.com,
        Anup Patel <anup@brainfault.org>,
        Evan Green <evan@rivosinc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/2] RISC-V: mm: Restrict address space for sv39,sv48,sv57
Message-ID: <ZJtzEn9Yut3nPuw8@ghost>
References: <20230627222152.177716-1-charlie@rivosinc.com>
 <20230627222152.177716-2-charlie@rivosinc.com>
 <473F7474-D7AA-4C9F-95A3-320F1741EC50@jrtc27.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <473F7474-D7AA-4C9F-95A3-320F1741EC50@jrtc27.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Yes it is small to have a default of 38-bits of userspace. I would be
interesting in the opinions of other people on whether it would be
acceptable to have the default be sv48 and require applications that
prefer fewer bits to specify so with the given mmap hinting.
