Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9421F7CFAA1
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Oct 2023 15:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345748AbjJSNOA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Oct 2023 09:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235383AbjJSNN7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Oct 2023 09:13:59 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBE411B
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Oct 2023 06:13:57 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-313e742a787so470619f8f.1
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Oct 2023 06:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1697721235; x=1698326035; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N03EBFrOrhm4ozhPfKNWvNg3xihPBb+hk1YZrDAavPs=;
        b=eqes1V25OAkuybz6hBU7iZxhKrTDyUotvbAA50EzYYsSSAahOSX0OLx0/avdz4UjCJ
         nPb+zOJzN56bgSnmAID8Oh+/Ew9AG/zKO7MRcJ3BIR2dp6ZsET9gNwjnhz7To/1PSXuD
         aVgFqT4sVYGJbJKZQzMJ3RHGnzknNAiSdkPI4j7nimm70/eJidxKlzSg/KRTyo+6s2eq
         SiXZ16SsxETATuEnYwCJm5EjA+B8Of++DE5A29XJj0tFl2h7uoJhqoSve0pswa0js0yf
         9aAypnu752U2rhuJR5wkZUwnJ7cXQoLP9tRac7m1793cjFAMTiMhpl6n05oi2izGcbVD
         YoQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697721235; x=1698326035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N03EBFrOrhm4ozhPfKNWvNg3xihPBb+hk1YZrDAavPs=;
        b=Aijk+7bKNzsgOcuUCfRIPmMIHJ25msKe4sz9o3kzEPXvUYdNEOX5a2su2EwPelqyQj
         ITbuG7VGwNHGYss0i764Dy4KodjsaH+RyOgDAbv82IILKq5gTe32wSvLNCzVDU3EBRlw
         AMH19W2EGynqGuKJzpWYDLNkr7RKyH/Kvt+E57aeUIko3w2AGymrJZcRxztLzc5s+ygg
         OQAa9CqdTkVC/7TnslfuiqAquQg7bIdeyvaDPsJinHFtH7XcnspXfTER6FpYmxjd+roD
         1GqLcyzka6rAaQMAJZeXRBIk4yOUMKyKUJ83kESOerm17P5qJzhR6xLxjPyc+G+OGoCb
         JRDQ==
X-Gm-Message-State: AOJu0YyCVqDsiXtCpkEKN73w9GuuWjR9FuseavhSbjjDMJkkdRcUACfh
        NOe7cfvKghqFyXZHx4s1zt4vwg==
X-Google-Smtp-Source: AGHT+IHVpuS8hLyuLWw4Px3QWlJbDZ+QDUh/yMexumeLdkjcwmWR59jO4qWMTCApvVqtlz0eu/0iSw==
X-Received: by 2002:a5d:4fca:0:b0:32d:dcee:a909 with SMTP id h10-20020a5d4fca000000b0032ddceea909mr1535446wrw.1.1697721234645;
        Thu, 19 Oct 2023 06:13:54 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id s5-20020a5d69c5000000b0032db8cccd3asm4439698wrw.114.2023.10.19.06.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 06:13:53 -0700 (PDT)
Date:   Thu, 19 Oct 2023 15:13:52 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Thomas Huth <thuth@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: selftests: Use TAP in the steal_time test
Message-ID: <20231019-2946dcc38c3e95e0e7433eae@orel>
References: <20231019095900.450467-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019095900.450467-1-thuth@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 19, 2023 at 11:59:00AM +0200, Thomas Huth wrote:
> For easier use of the tests in automation and for having some
> status information for the user while the test is running, let's
> provide some TAP output in this test.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  NB: This patch does not use the interface from kselftest_harness.h
>      since it is not very suitable for the for-loop in this patch.
> 
>  tools/testing/selftests/kvm/steal_time.c | 46 ++++++++++++------------
>  1 file changed, 23 insertions(+), 23 deletions(-)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
