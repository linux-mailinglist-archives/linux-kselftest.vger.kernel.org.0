Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C230673FDC8
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Jun 2023 16:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjF0O0S (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Jun 2023 10:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbjF0O0R (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Jun 2023 10:26:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35E2273C
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Jun 2023 07:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687875932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vGSc4mdTDNNjtXngrQkAE2Vk0OODhwWQe551QFWP1tI=;
        b=Ffkb9gxXPxDnb4vbueLitz3YRK6AHWv2HOdGAhLNL65ry16uHvjIy9hVVgd6hD0JasnVSG
        IbC7bcvDIeQ/lN39NJh7+yfDhF9pfu0KY9FDsscqxKePNsDbnJCsX2q4sx33fdIL+mPBse
        +TrbmiO46JHEW7/fdgdQEaEeWnIRcLw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-AiZK14ZSMNORvP-YHolfQA-1; Tue, 27 Jun 2023 10:25:16 -0400
X-MC-Unique: AiZK14ZSMNORvP-YHolfQA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-94a341efd9aso273878366b.0
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Jun 2023 07:25:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687875915; x=1690467915;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vGSc4mdTDNNjtXngrQkAE2Vk0OODhwWQe551QFWP1tI=;
        b=PlNaAGrMaFwhN+2YTYL+kyMhjdHCpU+3u+fpfQ1p9V2ZtKQ0JQq3EeiI5EkGNxtcKT
         HKPzK6CCfHZFUBqU7KSw7remmCXzXTR7sSOOlbXcnx3kakMBL+7U5BDSghl1Mu6vDu7f
         XZgf9cIZWXqCwOX8Qvb0Y0o5jk4UDFTlkDEkWPJV+Se2G+dphED1Y9DT9SfEByc2UftF
         dSNWkcrK1m7i3ew4/nt3ysjhL3x9PPiJCzg+AQcQq2pvQbFk8178xVBei71e8eukq7Jn
         DLFA+uuj76TmYcK4927sUGrnZr3bDq2bhC6F9PAQAaegqbygv0uDEWgnbfYTFQutb61+
         sqmA==
X-Gm-Message-State: AC+VfDwUmr3z7X7fse8yIttQy6IqMVPHImd3LJa2VIHfzf27mx0N9UvM
        mUSpBAOIrAsHLDVyJfyKEIE9dCagwmhbkZNPWBZU2TA0oQWmtdQNwmxwXKZsk+wECzU3/G35j1d
        78BJfOahtaXq4hXzmD+Fg6KGtujz54N3XKLBX
X-Received: by 2002:a17:906:da8b:b0:982:26c5:6525 with SMTP id xh11-20020a170906da8b00b0098226c56525mr32188638ejb.60.1687875914698;
        Tue, 27 Jun 2023 07:25:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6i5PkNbA3Uw3V9yHzNgEF6zgc+6XvzXai4Ju+na594EFjrV8ZjoKAuLT8tuRH4vcpCqG3Dfw==
X-Received: by 2002:a17:906:da8b:b0:982:26c5:6525 with SMTP id xh11-20020a170906da8b00b0098226c56525mr32188620ejb.60.1687875914199;
        Tue, 27 Jun 2023 07:25:14 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id qn1-20020a170907210100b0098e42bef731sm3234766ejb.169.2023.06.27.07.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 07:25:13 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 2921ABBFF6C; Tue, 27 Jun 2023 16:25:13 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Xu <dxu@dxuuu.xyz>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, coreteam@netfilter.org,
        netfilter-devel@vger.kernel.org, fw@strlen.de, daniel@iogearbox.net
Cc:     dsahern@kernel.org
Subject: Re: [PATCH bpf-next 0/7] Support defragmenting IPv(4|6) packets in BPF
In-Reply-To: <cover.1687819413.git.dxu@dxuuu.xyz>
References: <cover.1687819413.git.dxu@dxuuu.xyz>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 27 Jun 2023 16:25:13 +0200
Message-ID: <874jmthtiu.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> The basic idea is we bump a refcnt on the netfilter defrag module and
> then run the bpf prog after the defrag module runs. This allows bpf
> progs to transparently see full, reassembled packets. The nice thing
> about this is that progs don't have to carry around logic to detect
> fragments.

One high-level comment after glancing through the series: Instead of
allocating a flag specifically for the defrag module, why not support
loading (and holding) arbitrary netfilter modules in the UAPI? If we
need to allocate a new flag every time someone wants to use a netfilter
module along with BPF we'll run out of flags pretty quickly :)

-Toke

