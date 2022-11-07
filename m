Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9002E61EB13
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Nov 2022 07:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbiKGGiZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 01:38:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiKGGiZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 01:38:25 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0086EE82
        for <linux-kselftest@vger.kernel.org>; Sun,  6 Nov 2022 22:38:23 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so13592486pjc.3
        for <linux-kselftest@vger.kernel.org>; Sun, 06 Nov 2022 22:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W6yu/HMdn7Jkub/3b0dmYYkkQv71FItSNWFiTNSPq50=;
        b=Gz5V08vmne0nLUBBkA4xxDNUk6kb/hngX27bEnBPfy8ltdrPEdZ1ft0x8m+edcsWdh
         +QXx9zB1ePw4DLZcK7WfzqIn3X/d1OOKGBa/3VtJ3Kpe4Ujy574Xa+c+iVR+PfUBFYn4
         9apexXYj5gCc7RjvYV1NngWQ6y7NUm91crWlpXjYXXH3FXliB3Ot5+vCbSuwWmHSxjw3
         sCmCG9ZCAEMEAFz1nmunXr8I8k4bYdh8mJIO0r25zGAiySKU/2HGNeAEY9BpEIKFmSAk
         AmF7bld223jVbUQk+Dh2RFxQZzfSzreHGLvN0g9QY3F9sGosG6g1H/TDoez2C5UWRPmL
         QcRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W6yu/HMdn7Jkub/3b0dmYYkkQv71FItSNWFiTNSPq50=;
        b=PXAQP0KaYz9Sf1J7Pqi/yQ8ewYjsT13ImadZG3rj2nTaUb1OHBK2UqkM0aSvFyzgRU
         pEZy8q4zw0XibXUhKjE7UKd4zYod92i1Q29VamteKBhG4Re4gPZO//TkrS9WZA3fUWWJ
         UVq2p0hRcJeSzf1zlt0DlKtGwZDb1gGiSQkh1zBgyOMHN75Za+xWcSo/yUCvPno9VIps
         GpKpGqnUa22A8+88kbdSdsOHrsTm9j4qwIqlO7/Cp04hiFmy8+JJEd9vEIuWHpTBteOm
         aWK0whPbCzhj9Jy0gJnnEnuSzmAirJ1FqiQRigMn2vtHSsS4y6iwu5VUx0E5UoIat4/p
         OueQ==
X-Gm-Message-State: ACrzQf0rYsv1nAiEdXME6Xv6zb6mKfpYRK1t42kTaVMJheuYO8xW12xN
        ay6AVE0qJhOUNOo7Nv4tqw33rw==
X-Google-Smtp-Source: AMsMyM7WD6AWzZc4ZGVkkDqHSDfQz7DCf64dpCKMeQy6ET/KQiuYlGgdP2qCw7fQh4QcKUv7RJqK+A==
X-Received: by 2002:a17:902:da8e:b0:187:5b6:1b9e with SMTP id j14-20020a170902da8e00b0018705b61b9emr50343169plx.113.1667803103407;
        Sun, 06 Nov 2022 22:38:23 -0800 (PST)
Received: from minbar.home.kylehuey.com (c-71-198-251-229.hsd1.ca.comcast.net. [71.198.251.229])
        by smtp.gmail.com with ESMTPSA id b20-20020a63d814000000b004468cb97c01sm3453803pgh.56.2022.11.06.22.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 22:38:22 -0800 (PST)
From:   Kyle Huey <me@kylehuey.com>
X-Google-Original-From: Kyle Huey <khuey@kylehuey.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Robert O'Callahan <robert@ocallahan.org>,
        David Manouchehri <david.manouchehri@riseup.net>
Subject: [RESEND PATCH v6] x86/fpu: Trying to fix writing PKRU through ptrace
Date:   Sun,  6 Nov 2022 22:38:06 -0800
Message-Id: <20221107063807.81774-1-khuey@kylehuey.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


Hello Linus,

I've been trying since July to get this regression that was introduced in
5.14 fixed. This is my third time submitting this version of the patch in the
last two months. Both prior submissions have not received any comments from
(nor have they been applied by) the x86 maintainers. I don't really know
what else to do at this point beyond "complain to the management" as it
were.

I appreciate anything you can do to unjam things here.

- Kyle

