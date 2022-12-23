Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93FAF6552EE
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Dec 2022 17:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbiLWQqv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 23 Dec 2022 11:46:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbiLWQqd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Dec 2022 11:46:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226E42734
        for <linux-kselftest@vger.kernel.org>; Fri, 23 Dec 2022 08:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671813948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2P7wb2jYiHju8X65PSWfviKi+RGDuevtVJeM6R/Rnj8=;
        b=XvcpNZD2FwNsBinkVi/zP47jon+YgIAHeGhJwBqHBeSvW5cXxwQkCQgm7xbDgmLMGS++j3
        1PkiTk7vXkDq+yMswi60+DIjiyRNvaEGCQFQCqj9FePygUkNvNI3p9qruSy+8LW7ZaKNgf
        3M9U1xLHX4e11pL5vBYD9o1nR5swFl8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-332-mHXwYqKvMemb0qBTfIpiQw-1; Fri, 23 Dec 2022 11:45:47 -0500
X-MC-Unique: mHXwYqKvMemb0qBTfIpiQw-1
Received: by mail-ed1-f71.google.com with SMTP id y2-20020a056402440200b004779fcdf1baso3974027eda.4
        for <linux-kselftest@vger.kernel.org>; Fri, 23 Dec 2022 08:45:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2P7wb2jYiHju8X65PSWfviKi+RGDuevtVJeM6R/Rnj8=;
        b=gU/X7bhxhteUxpgLBGcBgTgKxWceyrBX2Go78oycVU48FjoF8UibsXup6RRfzPIAhb
         T9Whx4YxbN/KSriv3O9SUr04IP+tVFBEkMJ8sXDR36vjpfLE8FKYYQ+o7tg5v69V9W+c
         MFIQlDr61BhWIajn/6C3+Zlsev8kZsrraMxuuWhYPp+vO25CVcyM2LuoaKsYWXsOI5Zn
         3WL+U6pP1JrKsFRh5/QCCEVntQ1eG9FSlxTtmkI0Nw14rnPussptpfQKekQY+0zXLs+d
         7V6U3qZrMyZkNSnXF33XX7bIkjBrXBXZjtroBHB+f+sRlNDay9umjgWUzhzMs1hbJSVR
         lqKg==
X-Gm-Message-State: AFqh2kpDQDu/UkONqVzpXMHMjriSip3mwpt2/t/6GoBtmzeeEGtZ01rt
        s+wYpB2KELn2tBdhM60y73JUEY85AiJvyvVs91uACv4lrIThlRKDdSHjN+i7vTNgn2TZO3n1UiO
        Fl1f5gPC+u4CGpJB03HM4/w/v6iXJ
X-Received: by 2002:a17:906:eb8f:b0:7ae:5473:fdb8 with SMTP id mh15-20020a170906eb8f00b007ae5473fdb8mr8267928ejb.22.1671813945977;
        Fri, 23 Dec 2022 08:45:45 -0800 (PST)
X-Google-Smtp-Source: AMrXdXukVWAYoII33XVIbh70Q55o2Wi4hGesgiBN++IKDnq0DyhaXO0YpEQLIHWdRG2I5tK3VKdEpg==
X-Received: by 2002:a17:906:eb8f:b0:7ae:5473:fdb8 with SMTP id mh15-20020a170906eb8f00b007ae5473fdb8mr8267913ejb.22.1671813945751;
        Fri, 23 Dec 2022 08:45:45 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id lr9-20020a170906fb8900b007be886f0db5sm1525901ejb.209.2022.12.23.08.45.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 08:45:45 -0800 (PST)
Message-ID: <d0519826-79ae-38b4-5ec2-04c7e0874ef6@redhat.com>
Date:   Fri, 23 Dec 2022 17:45:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 5.15 0/2] Fix kvm selftest build failures in linux-5.15.y
Content-Language: en-US
To:     Tyler Hicks <code@tyhicks.com>, gregkh@linuxfoundation.org,
        stable@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gavin Shan <gshan@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Karolina Drobnik <karolinadrobnik@gmail.com>,
        Mike Rapoport <rppt@kernel.org>
References: <20221223000958.729256-1-code@tyhicks.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20221223000958.729256-1-code@tyhicks.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/23/22 01:09, Tyler Hicks wrote:
> From: "Tyler Hicks" <code@tyhicks.com>
> 
> The backport of commit 05c2224d4b04 ("KVM: selftests: Fix number of
> pages for memory slot in memslot_modification_stress_test") broke the
> build of the KVM selftest memslot_modification_stress_test.c source file
> in two ways:
> 
> - Incorrectly assumed that max_t() was defined despite commit
>    5cf67a6051ea ("tools/include: Add _RET_IP_ and math definitions to
>    kernel.h") not being present
> - Incorrectly assumed that kvm_vm struct members could be directly
>    accessed despite b530eba14c70 ("KVM: selftests: Get rid of
>    kvm_util_internal.h") not being present
> 
> Backport the first commit, as it is simple enough. Work around the lack
> of the second commit by using the accessors to get to the kvm_vm struct
> members.
> 
> Note that the linux-6.0.y backport of commit 05c2224d4b04 ("KVM:
> selftests: Fix number of pages for memory slot in
> memslot_modification_stress_test") is fine because the two prerequisite
> commits, mentioned above, are both present in v6.0.
> 
> Tyler
> 
> Karolina Drobnik (1):
>    tools/include: Add _RET_IP_ and math definitions to kernel.h
> 
> Tyler Hicks (Microsoft) (1):
>    KVM: selftests: Fix build regression by using accessor function
> 
>   tools/include/linux/kernel.h                                | 6 ++++++
>   .../selftests/kvm/memslot_modification_stress_test.c        | 2 +-
>   2 files changed, 7 insertions(+), 1 deletion(-)
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

