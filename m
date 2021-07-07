Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E206D3BEF9C
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jul 2021 20:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbhGGSp6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Jul 2021 14:45:58 -0400
Received: from mail-pj1-f52.google.com ([209.85.216.52]:51817 "EHLO
        mail-pj1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbhGGSp6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Jul 2021 14:45:58 -0400
Received: by mail-pj1-f52.google.com with SMTP id n11so2081530pjo.1;
        Wed, 07 Jul 2021 11:43:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kbq2Q9RlsIgreJ0WcUVa9yByrqAK9omYnEmqA7Ouvv4=;
        b=bN90JOmPspNLPG8fS0GNfFcgrGQYhrXXxUNuMXYh8UByMLTIvFY+Hf7wgGEd9oCDLL
         ecM9Zp2U8lT+uh+H0VczXdKDMdXzqUFGBvmw4NQYgCujjfktBur80CvWZr2A0cbWF/YE
         iSFnRzfkmVtc5wC/ORYGA6SlbQDribxeWQmEVGxXN4FR97Gu15YoP/MRMnPv15/JLDi6
         KZ/NLx8EKb8QITGDYPZO/zgGBnfIbX+VVYxUClYCqC06PGG1rKSMshXoRM6VJiTlea4G
         v53ariRvZhzvgQ6wxQcQgxmLxiG7TOkuUOCPBU5SJdKp8k8jZ+iXPfg3Lhp9IwhKi/wx
         cPxw==
X-Gm-Message-State: AOAM533aBRf5RhtVCk0aTsL2unVbu6ZdsK/UBmNjevtDKyaeDpFs+1nu
        3UKMBgPces1eZdprNmFv4WI=
X-Google-Smtp-Source: ABdhPJx0ss49tYKKj51zls3YSnGjmx6pcjRTk9vSe+QrWOf2ZlYzyIoLjYLcux742b4JgWJEcu8MYg==
X-Received: by 2002:a17:90b:1297:: with SMTP id fw23mr436136pjb.37.1625683396820;
        Wed, 07 Jul 2021 11:43:16 -0700 (PDT)
Received: from localhost ([191.96.120.45])
        by smtp.gmail.com with ESMTPSA id v7sm22476658pgv.81.2021.07.07.11.43.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jul 2021 11:43:15 -0700 (PDT)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     gregkh@linuxfoundation.org, tglx@linutronix.de,
        akpm@linux-foundation.org, shuah@kernel.org
Cc:     rafael@kernel.org, rgoldwyn@suse.com, kuno@frob.nl,
        fontana@sharpeleven.org, Ciaran.Farrell@suse.com,
        Christopher.DeNicolo@suse.com, hch@lst.de, corbet@lwn.net,
        linux@leemhuis.info, ast@kernel.org, andriin@fb.com,
        daniel@iogearbox.net, atenart@kernel.org, alobakin@pm.me,
        weiwan@google.com, ap420073@gmail.com, tj@kernel.org,
        jeyu@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, minchan@kernel.org,
        mcgrof@kernel.org, axboe@kernel.dk, mbenes@suse.com,
        jpoimboe@redhat.com, keescook@chromium.org, jikos@kernel.org,
        rostedt@goodmis.org, peterz@infradead.org,
        linux-block@vger.kernel.org, linux-spdx@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        copyleft-next@lists.fedorahosted.org
Subject: [PATCH 0/2] LICENSES: add and use copyleft-next-0.3.1
Date:   Wed,  7 Jul 2021 11:43:08 -0700
Message-Id: <20210707184310.3624761-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This adds the copyleft-next-0.3.1 SPDX tag and replaces existing
boilerplate with the tag.

Luis Chamberlain (2):
  LICENSES: Add the copyleft-next-0.3.1 license
  testing: use the copyleft-next-0.3.1 SPDX tag

 LICENSES/dual/copyleft-next-0.3.1        | 237 +++++++++++++++++++++++
 lib/test_kmod.c                          |  12 +-
 lib/test_sysctl.c                        |  12 +-
 tools/testing/selftests/kmod/kmod.sh     |  13 +-
 tools/testing/selftests/sysctl/sysctl.sh |  12 +-
 5 files changed, 241 insertions(+), 45 deletions(-)
 create mode 100644 LICENSES/dual/copyleft-next-0.3.1

-- 
2.27.0

