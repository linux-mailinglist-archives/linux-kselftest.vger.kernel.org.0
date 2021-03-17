Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47AD133F883
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Mar 2021 19:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbhCQSyQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Mar 2021 14:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbhCQSyM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Mar 2021 14:54:12 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF77C06174A
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Mar 2021 11:54:12 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id g10so30285plt.8
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Mar 2021 11:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=rMyvcCmECo2UF5BrQ0BBNWIYi9bGONy40iMZu5iyOik=;
        b=nNqBakMSl8IOlJP8VjLFEVNGJ0s7A0Cm/0SrdHwHagrx/CjP3IXO6bwNoX0gISXwce
         H5D/P0RcWDi+nBaB76Sg2uELMIYV8PLRi+MojQBWRzAfibbDXQ3Q98MukRBTVA7i9j+0
         o6gFizrXvhM1yAZWXgRmdGTZZPGD7E3H07i5TDWcAUWReX6jCIJI2lIiVNuiZx0Vju3c
         LRK+dAjPPiXH14E5U+ZGImniyBP5onJs4N7uxM0vihP1k+gNDHtOcp+QaK8ZWSm5Mgj5
         AfpIwmqlio95IH8VIo/vq99aHeSWnpaVh74XQnE0eTAXUj9esOk/qvo+CmF5jEYUyxy+
         R4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=rMyvcCmECo2UF5BrQ0BBNWIYi9bGONy40iMZu5iyOik=;
        b=AgR/4Qb5XlPPipO0bCnJSS5+Dj7hjpzbvw9ckYmEG92SqW9O/EN5ekua5vfv0aFDie
         Pc+DyGV3c3dQKVdxU1RoXZqEOmHRQrOJzg5U7v/13SXE9mIVUuWyHbW8/KqieZibABPa
         fuBRO3DqG+lsX3KcyDFua7yRGi3c3lNR4IPg5pYoWHebbTrwRoucrPu2SXN8XhshLRHw
         v8ynaqnbZcUMgyqDnYJ/4KuIwx/VILwEnPTzWqMuEBl5L78X9EnHCa7Xa49tIQ+9nIW1
         crt5L/eUpyB4Xe+vxLoCF44YBV7pEkrvj30UP38Da3iWWKrP9regRv3B3gqrVm+3jaRO
         lCcw==
X-Gm-Message-State: AOAM530uwGr+ysj2/6gtwBfzsl4BClhJj3C07SUiTXTesHaxuJ54piXv
        DC9yvYVZp+W0EPqxqcao05ZiYg==
X-Google-Smtp-Source: ABdhPJxoJ/lR426aplD+YyMkxVJUtHq6Vt1FBVhabjeKlgXTrUcdrMGKFzdHnIdTH+dr9vJJdjvERw==
X-Received: by 2002:a17:90b:514:: with SMTP id r20mr247990pjz.145.1616007251900;
        Wed, 17 Mar 2021 11:54:11 -0700 (PDT)
Received: from [2620:15c:17:3:b56a:51db:a0a1:259f] ([2620:15c:17:3:b56a:51db:a0a1:259f])
        by smtp.gmail.com with ESMTPSA id y9sm3522935pja.50.2021.03.17.11.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 11:54:11 -0700 (PDT)
Date:   Wed, 17 Mar 2021 11:54:10 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Oliver Glitta <glittao@gmail.com>
cc:     cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] selftests: add a kselftest for SLUB debugging
 functionality
In-Reply-To: <20210316124118.6874-1-glittao@gmail.com>
Message-ID: <982058b5-6db0-d85d-126b-502f24447528@google.com>
References: <20210316124118.6874-1-glittao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 16 Mar 2021, glittao@gmail.com wrote:

> From: Oliver Glitta <glittao@gmail.com>
> 
> SLUB has resiliency_test() function which is hidden behind #ifdef
> SLUB_RESILIENCY_TEST that is not part of Kconfig, so nobody
> runs it. Kselftest should proper replacement for it.
> 
> Try changing byte in redzone after allocation and changing
> pointer to next free node, first byte, 50th byte and redzone
> byte. Check if validation finds errors.
> 
> There are several differences from the original resiliency test:
> Tests create own caches with known state instead of corrupting
> shared kmalloc caches.
> 
> The corruption of freepointer uses correct offset, the original
> resiliency test got broken with freepointer changes.
> 
> Scratch changing random byte test, because it does not have
> meaning in this form where we need deterministic results.
> 
> Add new option CONFIG_TEST_SLUB in Kconfig.
> 
> Add parameter to function validate_slab_cache() to return
> number of errors in cache.
> 
> Signed-off-by: Oliver Glitta <glittao@gmail.com>

Acked-by: David Rientjes <rientjes@google.com>
