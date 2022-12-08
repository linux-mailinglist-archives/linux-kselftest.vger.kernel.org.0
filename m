Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006FD647423
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Dec 2022 17:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbiLHQXj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Dec 2022 11:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbiLHQXd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Dec 2022 11:23:33 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217E060B7F
        for <linux-kselftest@vger.kernel.org>; Thu,  8 Dec 2022 08:23:24 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id b2so5240314eja.7
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Dec 2022 08:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3ffOMrqHbGPKnX9DON08suhw00B/x5l9qlgIhBCvn1s=;
        b=GcVbR78qgq1zGKeFap4dpyJP2ETn3kww5rg3v8dPl3tCWN0G6qxnGcbwgcX5MCo3OM
         fKWfEFTBvO7N8XCZBPsxpIZJu/I7SUe3aPGwiRpN/CQgiksUDLrb6z4cKnWd08AfEpdZ
         r94BbeUn5ovd//wzHhKXPJAWTKlrbHK2MlOIz3fbM4mGNb97gj9dHvVIeeiBbVWMUG83
         kIoNpiUMsufVsm/m95AH/BSknL/IIYi4+Au5NXHpzpAF6U9MwGhYl2DJgI8UrQgHnbO0
         7dRNIeeoHyKJg18727lHNV+cCrVrJsiUn1rn7oMXL7Wu9l4f3Ev75gNhks+qShMbBZI8
         WEAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ffOMrqHbGPKnX9DON08suhw00B/x5l9qlgIhBCvn1s=;
        b=SGrM/ohUFqQ+fotNf8KXYE/P1awInCv2KM+sPJVtivnVsFIJKHGh0cRSPtORPnFSbA
         nhizzji44Ud+bNsvZFrGyVbrSfjMeJ1u58CnphnHcR9tOjFcmgEhYnwo3iSqQYjg8lv1
         PXi9IPAfODKzJGBB59iEdeWEMTa3ix/EOWTQuxVxmcQly3m2ddTvlDC7ba19HljeFtCz
         DVPm+MsunfhtmlP3vVypi0tucd2tt/7pmRdzfOHThu8ve8dXU6ubjt1eIdYahN++4z22
         PRmM83776CSCjBhC7W73vec7IXdoxWF81ihv8z/fzZn2NdPc1umVl+8fMQUPuMe2e2bb
         iz7w==
X-Gm-Message-State: ANoB5pnS5bCJ2whQUD3OxA6cxqYyhXe0OA0SJOLqRD5c1DORsPUrJEra
        z7F7YRVaDckWIABO5VBkx7jhig==
X-Google-Smtp-Source: AA0mqf7cWc12/11dRI8UuaKffduEO9pgwBnCtENeaj4X4vsk2ZRqNQGH/MayWHmkzyTTju2hui+ZmA==
X-Received: by 2002:a17:907:a426:b0:78d:f456:1ec6 with SMTP id sg38-20020a170907a42600b0078df4561ec6mr3278655ejc.23.1670516602675;
        Thu, 08 Dec 2022 08:23:22 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-748-2a9a-a2a6-1362.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:748:2a9a:a2a6:1362])
        by smtp.gmail.com with ESMTPSA id i9-20020a170906698900b007bff9fb211fsm9884789ejr.57.2022.12.08.08.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 08:23:22 -0800 (PST)
Date:   Thu, 8 Dec 2022 17:23:21 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Oliver Upton <oliver.upton@linux.dev>, kvm@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kvmarm@lists.linux.dev,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/4] KVM: arm64: selftests: Align VA space allocator with
 TTBR0
Message-ID: <20221208162321.d745p2lsedxdf7v6@kamzik>
References: <20221207214809.489070-1-oliver.upton@linux.dev>
 <20221207214809.489070-4-oliver.upton@linux.dev>
 <Y5EtP5z6rxSK1VUe@google.com>
 <Y5EvVtAoDSHvIKie@google.com>
 <Y5E5UixcJQ4+tNYg@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5E5UixcJQ4+tNYg@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 08, 2022 at 01:09:38AM +0000, Sean Christopherson wrote:
...
> Actually, before we do anything, we should get confirmation from the s390 and
> RISC-V folks on whether they have a canonical hole like x86, i.e. maybe x86 is
> the oddball.

riscv splits like x86.

Thanks,
drew
