Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622A17AD9E3
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Sep 2023 16:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbjIYOQU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Sep 2023 10:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjIYOQU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Sep 2023 10:16:20 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D54CFC
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Sep 2023 07:16:13 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-533d31a8523so4059080a12.1
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Sep 2023 07:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695651372; x=1696256172; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NtHT6aiMIDBr0VhsvuAUelOWNt+yCga/yEkC3vej9HA=;
        b=DRDrjOTcdt6DhF5MyxOpP2MAcZi+3g6VF2dvO3kILu+kjJVYg6QPGucwTrEykKtthL
         jDBzUusJ0zcgu2C7wNU+kDziyy4qjdH3BQXFAwkK2sCpgRvU7dG8btmyA/x/qabRJnzh
         ZKP+AgFSNr7KFIXzzegzQynfJVzzeJHa5syMjEROweQWMJW+c+7N8g1Ve+R5ZxK/zlIl
         ThxSmpiu79PVx0xy8JXa89Ntwxsd2LewnOg1Jo35v+/2zHRaDU6NJteO3atZ558cJhAX
         f1hWCK2Z7ebyl5HR7zsHl+XcfK6BnjTzfL0b4SEXSQ6lDPI5YCeBzDBXR7Xrmjq0pwox
         I27w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695651372; x=1696256172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NtHT6aiMIDBr0VhsvuAUelOWNt+yCga/yEkC3vej9HA=;
        b=kJk4CyUQkdYfrYlSzf6i92FIinNt09iLBB0ZluQ49MWDoYq3nCu+cv5VckqU0NgHMG
         M0k8HYhQHaecaheo6PRcRc+KC+/S7xhMV90U8LHg/Kc7fpXU3/Am0BmxPvspHvkyhwAp
         cauR4CdxTXyJYmwh0XyJVlnCqXVpOjcmfLVg+L/K+U8gN0oc06nGlKlGsCovniBm4PB9
         co9LnFppiOk0aKX4Dq1W/7DbDA+SQ5qMhs7MCFPLeLYnWamAjCFV4BuNkGMQRiwD3pcw
         Nk7V+qxBglXYzbjb73mh11Jcq1daBarJPrHWt2Q9Q+JZyf/jZu00jMtvlYjcFpQ0CVw5
         gmWQ==
X-Gm-Message-State: AOJu0YwBSpibxQYv0pzSB657NPiWvQzmup8d+lkNPXxqf/3kqG6uvGYv
        /q4utswd07s4rdSa51fyh0KbIQ==
X-Google-Smtp-Source: AGHT+IFD3EpGZBsAbJ+J5vxX8ZTKeYXM/hyB7APD30MTz1CFpgRcVl20BIQ92V7DyV6X8ncqPzNWDQ==
X-Received: by 2002:aa7:d1d0:0:b0:530:a0a9:ee36 with SMTP id g16-20020aa7d1d0000000b00530a0a9ee36mr5827166edp.38.1695651371793;
        Mon, 25 Sep 2023 07:16:11 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id q6-20020aa7da86000000b005307e75d24dsm5531414eds.17.2023.09.25.07.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 07:16:10 -0700 (PDT)
Date:   Mon, 25 Sep 2023 16:16:09 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        devicetree@vger.kernel.org, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 9/9] KVM: riscv: selftests: Add condops extensions to
 get-reg-list test
Message-ID: <20230925-3ceb6ef98455349935bcd504@orel>
References: <20230925133859.1735879-1-apatel@ventanamicro.com>
 <20230925133859.1735879-10-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925133859.1735879-10-apatel@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Sep 25, 2023 at 07:08:59PM +0530, Anup Patel wrote:
> We have a new conditional operations related ISA extensions so let us
> add these extensions to get-reg-list test.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  .../selftests/kvm/riscv/get-reg-list.c        | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
