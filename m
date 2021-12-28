Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5ED9480DED
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Dec 2021 00:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237814AbhL1Xi5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Dec 2021 18:38:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237811AbhL1Xi5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Dec 2021 18:38:57 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF1BC06173F
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Dec 2021 15:38:57 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id r16-20020a17090a0ad000b001b276aa3aabso9763491pje.0
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Dec 2021 15:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mLJEKnUeVA+ZJaDeVq7C58HVHq2F7qzWQ7vIWWcH/9I=;
        b=Eiy8qoIw/+H+Jfx8mcv3/R1UdB2Av9PpBgReHTaaSLr7QNRpRxLq2Xr0kD7QHsDQLc
         jMqa1zT3VYLLajjYXGcTlBJkLplBff49xgT6WYc+qinCxPYmRcHZqFl1331GvJWLiTPM
         UMB3HWJWlGt64de9dAl0DBNGEudpy6kP1IT9QM35aydC9vFp3PaU8s3D433UtOgV09Wf
         USNkA1zZQqpuG59EIU44pHjzNmo61hM+1bBpTMMLERNSDAI0UV/88SjncVcabfNKo1SW
         OIYUccn9ZusVP6iipAYQiS29AeygpxEa6zqUL+91px6gBunwGQBepHO7GRI2Y+8/xJUM
         wjBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mLJEKnUeVA+ZJaDeVq7C58HVHq2F7qzWQ7vIWWcH/9I=;
        b=L2FabhpV8GT8jAOY1WXwAJu9GgGjA/MXbax3TU/oL6DhwE9W9VluA8rsh1OsB9ekBK
         LbvoLTIE+Em8bDunSQfWIlq6+zBrcekukHGs2ELqxmznseVxluVkDq0t27mXzqkKi0lY
         j2AuUdSlAQcYhXx7MV6ZNy/6bFzEysTQuaQ+WafzFrMtKm43B59PtklV471Y58D12HjX
         TjA8UEpZEtv3bF1zePCl/9w7H04h336jvZJolnsbAEJf6c2Yfi9n01zr6Bw7JabZhbu2
         ZaG4TkncD5d5fF0mkQGQIkMENcv0uoK8S4xP5Oi3JGYaaFQ4iAZRzrm5EOT2p6oiOPKF
         4O8w==
X-Gm-Message-State: AOAM531WqzUaX4bmzK3338sYl9qjYI7V/1HTO2SAMY0olEvn/tw9DymO
        /emch65ex7GG9Fr95J+Tu0/pDA==
X-Google-Smtp-Source: ABdhPJyznVD+crKQ6G6u0OsCozPGqZlakrH/5IfbsFoLhMCKNUnUBjBp31t4ativuEsftnsU7jqacA==
X-Received: by 2002:a17:902:c401:b0:149:353c:9705 with SMTP id k1-20020a170902c40100b00149353c9705mr23328628plk.23.1640734736553;
        Tue, 28 Dec 2021 15:38:56 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id f7sm19397673pfc.141.2021.12.28.15.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 15:38:56 -0800 (PST)
Date:   Tue, 28 Dec 2021 23:38:52 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Jing Liu <jing2.liu@intel.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, pbonzini@redhat.com, corbet@lwn.net,
        shuah@kernel.org, jun.nakajima@intel.com, kevin.tian@intel.com,
        jing2.liu@linux.intel.com, guang.zeng@intel.com,
        wei.w.wang@intel.com, yang.zhong@intel.com
Subject: Re: [PATCH v3 05/22] kvm: x86: Check permitted dynamic xfeatures at
 KVM_SET_CPUID2
Message-ID: <YcugDN+9d8t4r9bV@google.com>
References: <20211222124052.644626-1-jing2.liu@intel.com>
 <20211222124052.644626-6-jing2.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211222124052.644626-6-jing2.liu@intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Dec 22, 2021, Jing Liu wrote:
> Guest xstate permissions should be set by userspace VMM before vcpu
> creation. Extend KVM_SET_CPUID2 to verify that every feature reported
> in CPUID[0xD] has proper permission set.

Why?  Nothing in the changelog, code, or comments explains why KVM _needs_ to prevent
userspace from advertising bogus features to the guest.  E.g. the virtual address
width check exists because _KVM_ will do the wrong thing given a width other than 48
or 57, and explicity says as much in a comment.
