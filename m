Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B19683816
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Jan 2023 21:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbjAaU5N (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Jan 2023 15:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbjAaU45 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Jan 2023 15:56:57 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91F15A824
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Jan 2023 12:56:24 -0800 (PST)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C8DF744302
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Jan 2023 20:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1675198566;
        bh=0j2ZICnG+w4G4N0kinwaAUyWnUe+Eo5pINxrbv2VLSM=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=pFbx/7XLF1WWrdGW/JP4VyOPC8y7ABLFKiBeN7BiowGd/lW9CIiOreVMMWkjJMMUU
         mZnc85yND/HmLSWl3pT/Qw1pke6aTADpljfvC5F8N1ukry7B3LlDkByAdwnpAM5dxB
         qfiUDwk8FYd8qoFetw2krqQnGIsMAPU24Qb42TAow4/T4lH8RnyzKUPoAHZnl+2amr
         dxmX+bw/jBOOyOpPun5pEGGKC+0He6fOeUIVPzFHJhzQpwC4I411tB3QnXGAjSY8Os
         D3YGhDea61puo79mfOVius/HMBD0ks+0IdcNFAeQuzZ3Ieh8rZD7rU6UeTJ/QbPVrX
         Pq3MR45PecPaw==
Received: by mail-wm1-f72.google.com with SMTP id h2-20020a1ccc02000000b003db1ded176dso6479106wmb.5
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Jan 2023 12:56:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0j2ZICnG+w4G4N0kinwaAUyWnUe+Eo5pINxrbv2VLSM=;
        b=S+AxVLYeaveZp2FzP4vxa0Qt/XT7Y1ky3O+Y8ZajYTqr/1nck4WFWmbIFclglEWwgd
         IkTHiZC4NWO9sOUDl+O30Q8nS2i5Gox4JuKATvX1+6BVQLvezFL45l8EyJj+N3kZJoVY
         S8OtphuhNpw/baaofgSJZaEhafjTMxWKKKUxQQDAH0SUsO/ln0vI7434/z+EH6dkH7pg
         VLXWQ55Gw1qe0Nt/xz5vNz2VNIEgznoGjEAXQoA2/zILU2t47/Gr8KTGh8MgRCuWFjzV
         1eW10HRL3GeY1vlsfuVdpfIBvTo/UQcCRDOm00qqTt5bUH3FsQYtvNK8XSlyW1yAOInP
         hNtw==
X-Gm-Message-State: AFqh2krRAwUaIy+Pz0rGVHrZ0B4Vcdza/cxDF/BMx4u3WGAaV5FbUKa4
        0W6iiy6+UdJaA3AoU56DzswUU31pQ9dBKbY0dcwhGw0d6MqKxPLPQPRsnWmFr7+tGRkAZ0vLmgG
        5oN4IN7HsMRv4G2OEmxkKnpa9x9uxCjWktvQ26c4p7OrUZA==
X-Received: by 2002:a05:600c:3d16:b0:3db:1ae8:ad98 with SMTP id bh22-20020a05600c3d1600b003db1ae8ad98mr48532204wmb.33.1675198565935;
        Tue, 31 Jan 2023 12:56:05 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvqDSHUeQD5Tnq9NnB4o+TBhnH6jqOD81n/j3Ubc2K7QwjKWheB/YHLYZttxP1P2b+R9LSkBg==
X-Received: by 2002:a05:600c:3d16:b0:3db:1ae8:ad98 with SMTP id bh22-20020a05600c3d1600b003db1ae8ad98mr48532198wmb.33.1675198565777;
        Tue, 31 Jan 2023 12:56:05 -0800 (PST)
Received: from qwirkle.internal ([81.2.157.149])
        by smtp.gmail.com with ESMTPSA id bd16-20020a05600c1f1000b003d1f3e9df3csm21316535wmb.7.2023.01.31.12.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 12:56:05 -0800 (PST)
From:   Andrei Gherzan <andrei.gherzan@canonical.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Willem de Bruijn <willemb@google.com>
Cc:     Andrei Gherzan <andrei.gherzan@canonical.com>,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 2/4] selftests: net: udpgso_bench_rx/tx: Stop when wrong CLI args are provided
Date:   Tue, 31 Jan 2023 20:53:18 +0000
Message-Id: <20230131205318.475414-2-andrei.gherzan@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230131205318.475414-1-andrei.gherzan@canonical.com>
References: <20230131205318.475414-1-andrei.gherzan@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Leaving unrecognized arguments buried in the output, can easily hide a
CLI/script typo. Avoid this by exiting when wrong arguments are provided to
the udpgso_bench test programs.

Fixes: 3a687bef148d ("selftests: udp gso benchmark")
Signed-off-by: Andrei Gherzan <andrei.gherzan@canonical.com>
CC: Willem de Bruijn <willemb@google.com>
---
 tools/testing/selftests/net/udpgso_bench_rx.c | 2 ++
 tools/testing/selftests/net/udpgso_bench_tx.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tools/testing/selftests/net/udpgso_bench_rx.c b/tools/testing/selftests/net/udpgso_bench_rx.c
index d0895bd1933f..4058c7451e70 100644
--- a/tools/testing/selftests/net/udpgso_bench_rx.c
+++ b/tools/testing/selftests/net/udpgso_bench_rx.c
@@ -336,6 +336,8 @@ static void parse_opts(int argc, char **argv)
 			cfg_verify = true;
 			cfg_read_all = true;
 			break;
+		default:
+			exit(1);
 		}
 	}
 
diff --git a/tools/testing/selftests/net/udpgso_bench_tx.c b/tools/testing/selftests/net/udpgso_bench_tx.c
index f1fdaa270291..b47b5c32039f 100644
--- a/tools/testing/selftests/net/udpgso_bench_tx.c
+++ b/tools/testing/selftests/net/udpgso_bench_tx.c
@@ -490,6 +490,8 @@ static void parse_opts(int argc, char **argv)
 		case 'z':
 			cfg_zerocopy = true;
 			break;
+		default:
+			exit(1);
 		}
 	}
 
-- 
2.34.1

