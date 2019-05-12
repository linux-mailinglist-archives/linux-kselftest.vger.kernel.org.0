Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0EC1AA7B
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 May 2019 06:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbfELEot (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 12 May 2019 00:44:49 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36180 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfELEot (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 12 May 2019 00:44:49 -0400
Received: by mail-io1-f65.google.com with SMTP id e19so7574500iob.3;
        Sat, 11 May 2019 21:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zrHaTsnyO7X3lAG2Au5Uox0L6Yni+OkaJRXpY0skhfE=;
        b=o0K4NHK1nlb721IvpP/v+EUPJBLrleV+3CVJWBapOqpriGzi71m8NfLSHF8myIOYPO
         eNKV/7CAYtHvAM1mr2FSDtLJxrMFMb3jjRu2J7bow3CW574BDp4j59bDfMXVI+bkuPVG
         xnWKQmXk5CdqLpg1grKQACoT731gv0W2xtXVIPMcD/4DeUn5KtFLyKnoH1yS4Sx6DvFt
         N0CcxF8MwvHWw+Go29LOX4zi9Owhg6zE6BnJOUS8fZgWTPeC41pV3FbnOp949bIZCNJO
         j61BY/dHxaVUpAXB434Q7BAp1Ko8Sny/0//4LOASek54xrKBp9+a3gkuNpqP4JIFwHrN
         uaBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zrHaTsnyO7X3lAG2Au5Uox0L6Yni+OkaJRXpY0skhfE=;
        b=fjhI3jUu76sXbeM+kWq2vQ8TrXtoOSsKCGLX0t6GPGTYBqcwUHl4tK3CdNoxf2Zwsr
         Dmz+UtygJ3yq3A/vZ/PcVT1a6eop8OK1NCVV3XbxyuZpzDpd45FT3Khb8U8hf6jA1dV1
         8scx3+SPpDgABAHAYBsDeALFr3BkaOGfeWKX7vg1Jsd59ZPY8zphGYKNP1dg4OBlsRYB
         h8a3Kxf5FWQvDHJJoO6UQeXpejGP+2zopU11PSOsSTBscjKALyxT1pmgFhX5twr3u/fS
         ZBvlLJDQzhfUKNwSHQtn0UgpXlPQ3VvQ0vhmbrQ9p1A0I96n+kq/35EY1AxXqCCtt37j
         tjpw==
X-Gm-Message-State: APjAAAXne71ij/NyzCmPMgDlcxIA3b6Ksic3wLu7IMNuAuLdLgA1MEtB
        43XaG4Muw7V3DAlUx6NOpS9Hd82NlJmNww==
X-Google-Smtp-Source: APXvYqyaP9IUOfuGcpYWiahhnCbCyp6mdD6ZYcHgDuEIZZQVLxZEwMgObC7LOAFPyAVRr/m1Kptidg==
X-Received: by 2002:a05:6602:1d6:: with SMTP id w22mr3217966iot.215.1557636288819;
        Sat, 11 May 2019 21:44:48 -0700 (PDT)
Received: from localhost.localdomain (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id f20sm3434642ioh.4.2019.05.11.21.44.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 May 2019 21:44:48 -0700 (PDT)
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     shuah@kernel.org, pbonzini@redhat.com, rkrcmar@redhat.com,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Cc:     Kelsey Skunberg <skunberg.kelsey@gmail.com>
Subject: [PATCH v2] selftests: kvm: Add files generated when compiled to .gitignore
Date:   Sat, 11 May 2019 22:44:34 -0600
Message-Id: <20190512044434.32627-1-skunberg.kelsey@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <5d60e7126803e9a11b51618e65966ba047eff7df>
References: <5d60e7126803e9a11b51618e65966ba047eff7df>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The following files are generated in /selftests/kvm/ after compiling and
should be added to /selftests/kvm/.gitignore:

        - /x86_64/hyperv_cpuid
	- /x86_64/smm_test
	- /clear_dirty_log_test

Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
---
Changes since v1:
        - Included /clear_dirty_log_test to .gitignore
        - Updated commit log to reflect file added

 tools/testing/selftests/kvm/.gitignore | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
index 2689d1ea6d7a..391a19231618 100644
--- a/tools/testing/selftests/kvm/.gitignore
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -6,4 +6,7 @@
 /x86_64/vmx_close_while_nested_test
 /x86_64/vmx_tsc_adjust_test
 /x86_64/state_test
+/x86_64/hyperv_cpuid
+/x86_64/smm_test
+/clear_dirty_log_test
 /dirty_log_test
--
2.20.1

