Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1404A7C9977
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Oct 2023 16:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjJOOR5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Oct 2023 10:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjJOORx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Oct 2023 10:17:53 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1FC136
        for <linux-kselftest@vger.kernel.org>; Sun, 15 Oct 2023 07:17:43 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c9de3f66e5so21036285ad.3
        for <linux-kselftest@vger.kernel.org>; Sun, 15 Oct 2023 07:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697379462; x=1697984262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kvSWVbZXn/MrVEcGpo16B6JSHdwZ2fR7rly5J6YWZNE=;
        b=RFS2pRpOPj0Fz3zbI6kHMAvLIv9pOZrbCw4IRXWqTM7IE4gIwhuZ7cMWL1lnx2NzjC
         JmP2knUtSyyY1syJLyq+qzp3nZc1bh+nyiKBD+XFfVODB9AmKmpspLEWul9jaksfPYFr
         gBcy3eEG55wtAaa0jTvrgZKvGgbxI3eEu1jJTw5zD9zCWhHyN3HfaBCMAEqTPM9AyP+R
         1C2HXXFQqdZ7eis759QCNODeaizm5UiraLBG3eSS/s6vVAZlmCMFmyTShNOh4Yb59fRT
         aHjvrGrh9h5WNqVk4iyDoarINlIy4OjJwRPgwySNoqVkKpXCYwohnBXH/4xDkepnrruM
         T9hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697379462; x=1697984262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kvSWVbZXn/MrVEcGpo16B6JSHdwZ2fR7rly5J6YWZNE=;
        b=g6TGjFqVRwkqb9NG11wmJDwHBIWFQu7pdVnPyC3k6mjR6+5vXLcD9a/1r+9hwilTEo
         2V31IA0pfBAtCO0ZrebPBbAuDd32f5gpMl1RjpAkftmP5ruqifMWcAYDSASVJw/Q/T1A
         6iaDUYs9wg36MhbG3/DRItllwyJhBL0nld9trwuRZqYM8JrHJ99zGAFsIDEGNflSZsQP
         gFkqD4Qsvi6oHGm3siHKaZm/4rx16dWQUdjwBgd2Y/xH1ncTgJ9LrZS9UHpI/6DdaWVa
         Qnuzr8YmXjjC5WfKQivGpP1/ms+XdjvrAfMbdGhbpcEGEvbw25BYwbYyAUiobRk3+nDP
         lK2A==
X-Gm-Message-State: AOJu0Yzq4MDsjNtSqEpdrQULH4ctIlBxBfy5A2pPnGaPQSGvo5LuJfCR
        CHD4E7AkJLc97kw3QfXD6DuY7Q==
X-Google-Smtp-Source: AGHT+IE81It/1ElAFh3WqzA1MDP6+KyM5FALauAhwzot5b7EduhSxG7C2ZYhheRbI8ll3TgU9FJn+A==
X-Received: by 2002:a17:902:aa48:b0:1c0:bcbc:d5d with SMTP id c8-20020a170902aa4800b001c0bcbc0d5dmr25880675plr.61.1697379461931;
        Sun, 15 Oct 2023 07:17:41 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
        by smtp.gmail.com with UTF8SMTPSA id d8-20020a170903230800b001c62c9d7289sm6869426plh.104.2023.10.15.07.17.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Oct 2023 07:17:41 -0700 (PDT)
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        linux-kselftest@vger.kernel.org,
        Yuri Benditovich <yuri.benditovich@daynix.com>,
        Andrew Melnychenko <andrew@daynix.com>,
        Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [RFC PATCH v2 4/7] virtio_net: Add virtio_net_hdr_v1_hash_from_skb()
Date:   Sun, 15 Oct 2023 23:16:32 +0900
Message-ID: <20231015141644.260646-5-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231015141644.260646-1-akihiko.odaki@daynix.com>
References: <20231015141644.260646-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

It is identical with virtio_net_hdr_from_skb() except that it
impelements hash reporting.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/linux/virtio_net.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 7b4dd69555e4..01e594b4586b 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -216,4 +216,26 @@ static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
 	return 0;
 }
 
+static inline int virtio_net_hdr_v1_hash_from_skb(const struct sk_buff *skb,
+						  struct virtio_net_hdr_v1_hash *hdr,
+						  bool little_endian,
+						  bool has_data_valid,
+						  int vlan_hlen,
+						  u32 hash_value,
+						  u16 hash_report)
+{
+	int ret;
+
+	memset(hdr, 0, sizeof(*hdr));
+
+	ret = virtio_net_hdr_from_skb(skb, (struct virtio_net_hdr *)hdr,
+				      little_endian, has_data_valid, vlan_hlen);
+	if (!ret) {
+		hdr->hash_value = cpu_to_le32(hash_value);
+		hdr->hash_report = cpu_to_le16(hash_report);
+	}
+
+	return ret;
+}
+
 #endif /* _LINUX_VIRTIO_NET_H */
-- 
2.42.0

