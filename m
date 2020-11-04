Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E511E2A66F6
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Nov 2020 16:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730456AbgKDPAX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Nov 2020 10:00:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22742 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729962AbgKDPAX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Nov 2020 10:00:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604502022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e6diWzy+RGM557EqcQ+SeKoKVh3DtYLPPbyK6Q8TIW0=;
        b=RUP6H9OxV9hzZ9zIwZG9GKedC1rIBDfgRH0wnMiFjP7k5uUfW7/N1VrE0giq9bdgriPQGI
        TqAKGUxKVc0sWveykkfmr6aWRJFbEaQbq8MB/CqRYgWsSTF0k7B1+rM6hfxTGaDRExPI7G
        n9Mr+COMNV2Te8j3N5G4ARKOGbzxaIM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-DHwITS1cNZirg0eCvV-fdg-1; Wed, 04 Nov 2020 10:00:20 -0500
X-MC-Unique: DHwITS1cNZirg0eCvV-fdg-1
Received: by mail-qk1-f199.google.com with SMTP id f9so13620572qkg.13
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Nov 2020 07:00:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e6diWzy+RGM557EqcQ+SeKoKVh3DtYLPPbyK6Q8TIW0=;
        b=RGvMQ+u1dLfJCdw57p4Ikx/2oCZAo2aRhPFNXWQ75KMhR+NeV19L4jheRlJ+Pz/K+e
         n+/4uywlegct3H35FGQ0E6vr0IS+xVRi0Om2J3jJR4vdSGurX/cd4UpzqHLyQi4bGAI2
         54zf3gGPAIL8kAQEdelQcZy/mAdHpjSU73h+NOmHrT5t+ygcsabpfVhFoC+NHNxQ3xni
         j/PdxcKLfiGpTO6tOGB5GCwojhmzmWt9GmXsumVQ6KcIP0Zis0egRjxhYsp81tIgP1lv
         fA96OHt+M+fGlQUMzekvtgnKTdAIIUBV7oGUnGeXSreAbnr0zWsEovsyG46WidsFLUrr
         IhrQ==
X-Gm-Message-State: AOAM53013+GT0JTnRoMGiSoTGjrlpE0PY6sx091YcVou+iGO34I2RBCl
        DEZc6UKsqdt0ihtuEpDHsMbjgxxU2uKZQfXsLMuECdiwAPn4wd3c2FUYKc+8haih8j+Y67t1UuM
        SCkb/sVy7Xmov9qu8Sg0XW8P9k/zS
X-Received: by 2002:a37:8107:: with SMTP id c7mr25368854qkd.361.1604502019980;
        Wed, 04 Nov 2020 07:00:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy2eY3k9i5ObOPHDM5/bO3oV4U3c5htFt8p/dm3ffz6awRll55ijhfh7CVBUmgdIdzrQQk4og==
X-Received: by 2002:a37:8107:: with SMTP id c7mr25368827qkd.361.1604502019710;
        Wed, 04 Nov 2020 07:00:19 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-196.dsl.bell.ca. [174.93.89.196])
        by smtp.gmail.com with ESMTPSA id g13sm266060qth.27.2020.11.04.07.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 07:00:18 -0800 (PST)
Date:   Wed, 4 Nov 2020 10:00:17 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Andrew Jones <drjones@redhat.com>
Cc:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Shier <pshier@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Huth <thuth@redhat.com>,
        Peter Feiner <pfeiner@google.com>
Subject: Re: [PATCH v2 2/5] KVM: selftests: Factor code out of
 demand_paging_test
Message-ID: <20201104150017.GN20600@xz-x1>
References: <20201103234952.1626730-1-bgardon@google.com>
 <20201103234952.1626730-3-bgardon@google.com>
 <20201104121631.wvodsw7agsrdhje4@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201104121631.wvodsw7agsrdhje4@kamzik.brq.redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 04, 2020 at 01:16:31PM +0100, Andrew Jones wrote:
> If you don't mind I'd like to try and cleanup / generalize / refactor
> demand_paging_test.c and dirty_log_test.c with a few patches first for
> you to base this work on. I can probably get something posted today
> or tomorrow.

Drew,

Would you consider picking up the two patches below in the dirty ring series if
you plan to rework the dirty log tests?  I got your r-b so I am making bold to
think I'm ok to ask this; I just want to avoid another potential conflict
within the series.

Thanks!

[1] https://lore.kernel.org/kvm/20201023183358.50607-11-peterx@redhat.com/
[2] https://lore.kernel.org/kvm/20201023183358.50607-12-peterx@redhat.com/

-- 
Peter Xu

