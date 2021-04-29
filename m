Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1932636EF93
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Apr 2021 20:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbhD2Sky (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Apr 2021 14:40:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59815 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241200AbhD2Sky (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Apr 2021 14:40:54 -0400
Received: from mail-pl1-f200.google.com ([209.85.214.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <tim.gardner@canonical.com>)
        id 1lcBa2-0001uU-1Q
        for linux-kselftest@vger.kernel.org; Thu, 29 Apr 2021 18:40:06 +0000
Received: by mail-pl1-f200.google.com with SMTP id q12-20020a170902edccb02900e6b86717d2so29322370plk.18
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Apr 2021 11:40:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6ISdJhxPA0Q81HhhbPQowkOtokNi1L68q+uJq16mjrQ=;
        b=NOL+e/pzUbGutPgZseKj9e3TrXeyNzfzqUuT+j11MrSEQGA6SOxIQOb0p9qOUMrg/U
         CnCIf3FEZmB00GcFfkQP9GBZ6JIURcNRp9LnxDR27YTHYEWtbDxGEUec/di6q9IcQ4Dc
         /aV3W/SNVGBzW0K5UwFwVWdQaW9pNv8TBzrvej3CBd83a5EonnKRpu8TQoCT1vT1K4dL
         JYTkquwnmfk8JRB7Htlf4DhHpi/7hJaaMXBRHIqNloe1rB3pGeeIsnCowf2lJ+GusZRv
         YGxs2jxUKSRkllDGbtZ3Hz1QmBx3Mpvjn+2mIBlnF0xibC90fRtb6gAf6lMfV1VTtqhz
         4g6A==
X-Gm-Message-State: AOAM531KetgcW3ImSv2Md2RD8uLrEqb0wIjj0rj4BDgfJwD3V+0ukzRI
        4zk0bILmgBd1VV01H4D+m3xF32gSP2s5JZpOAvivQSpgpnki/++i5pIeqaWN9VTJSLs3Aopfy4O
        VoxLS7XXGsSndLbdVqKVH2El6c4+pw7h1SXY/pSjy0XjCXQ==
X-Received: by 2002:a17:90a:c7d4:: with SMTP id gf20mr1275744pjb.106.1619721604717;
        Thu, 29 Apr 2021 11:40:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJznlTU0FLh/a/y3qttY/aCK6bTZoKBFq19ZesrnJ0eRu0rUGJ1crYWi4jCsj69yn9y3SLiV2w==
X-Received: by 2002:a17:90a:c7d4:: with SMTP id gf20mr1275724pjb.106.1619721604511;
        Thu, 29 Apr 2021 11:40:04 -0700 (PDT)
Received: from localhost.localdomain ([69.163.84.166])
        by smtp.gmail.com with ESMTPSA id i123sm3566618pfc.53.2021.04.29.11.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 11:40:03 -0700 (PDT)
From:   Tim Gardner <tim.gardner@canonical.com>
To:     dave.hansen@linux.intel.com
Cc:     tim.gardner@canonical.com, jarkko@kernel.org, shuah@kernel.org,
        linux-sgx@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Subject: [PATCH 0/1] SGX self test fails
Date:   Thu, 29 Apr 2021 12:39:51 -0600
Message-Id: <20210429183952.22797-1-tim.gardner@canonical.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

I'm just starting my learning curve on SGX, so I don't know if I've missed
some setup for the SGX device entries. After looking at arch/x86/kernel/cpu/sgx/driver.c
I see that there is no mode value for either sgx_dev_enclave or sgx_dev_provision.

With this patch I can get the SGX self test to complete:

sudo ./test_sgx
Warning: no execute permissions on device file /dev/sgx_enclave
0x0000000000000000 0x0000000000002000 0x03
0x0000000000002000 0x0000000000001000 0x05
0x0000000000003000 0x0000000000003000 0x03
SUCCESS

Is the warning even necessary ?

Tim


