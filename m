Return-Path: <linux-kselftest+bounces-43707-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B40CEBF953B
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 01:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C383318C84AC
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 23:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9038A2EFD9B;
	Tue, 21 Oct 2025 23:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HszNB7Zm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3472E9ECB
	for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 23:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090437; cv=none; b=mf157JYinpOa9NsJG7CRCPhNXbYhGOx2Go9YMbhcCk/DWtvjRMSwwrtu6gZzYuLh3gPiLc5Ei300rLforqibOf2NGAKm1UXgNlp5ANYhyE7ZYkL1mQUJGph3D3vsoW1x2EFSPE7r5rYRAyb7CYxsuRKJltDqQl3p2klaN3hlXtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090437; c=relaxed/simple;
	bh=Ah75iXsh0T8yhCIpU6zRS0eJQetFgIMRMgUlS91SRJ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UpJUm4B6CX20bqj+sc67hbELLOcXpQPraRhDtE92YdZlI+GJp9VaRfEoK/k193kD786dWquL8xxXkx0OqNlnK9d/QI2XtJ+M0MEm/eXRivWnmAhhh+WKuxxNraFtJ+oi85x0LjTvW/VDESO3ZrXo5mMvhAw5rt7fH+pW9FY35Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HszNB7Zm; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so422776b3a.1
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 16:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761090431; x=1761695231; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fnzs2zs6t5aqxB+IKVfd3RCQCLiGKiLLTWmUAKIpb/I=;
        b=HszNB7ZmWL1j0OpgxNRQ8G5r/LEmWqQPTqK/vSouCT3KFep+YG5xltDqXPiMH/E8xQ
         Wivc7hlRjGXZwwWu0MPONn0MTOV7qtYbeTaK5JyETTZULIPJUIDLwLaI/PUsUH3zlRqQ
         v5yN2FH5/bN/XN7IMV2mNwIvFmZNKFYAHPXGFEBQFUtb4LOKNZ0VS590DPlmSXtjszy0
         hSQWxOvH6di4vL2oWH8m/T5v04ylrdNiGHexQNgWEcjNgn81rH/kemiXZd5G2WSyLXdC
         Xt4aEmQ5EVEKJnOHcXbUASObth3aqKhmxlfCudv+D4jOhZDRGJZ5Il5G5RIevnAir6qf
         KDuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090431; x=1761695231;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fnzs2zs6t5aqxB+IKVfd3RCQCLiGKiLLTWmUAKIpb/I=;
        b=iKxAcmHe1H+gsd2iW9bKBC4/MKlde4cl0fbdTuJ+UK90bUOGQjIRp0Q1B7kZ4CFdPG
         kFfLIAFgZZB3h1EsuXhNHQhdAoyIpRiFAqXTAjrpwtJpsvwTKk0dVP4+yolUqRo5MEfn
         94xgiMxxVxpw8Grjz/0GW4608Hqxn/4axdypG2Un96IYOxLUyAG9sWNQXEZY9tAeU0Q5
         xpbYR5HI/V0V/3jWntB829X1E2TL/NcMdahM1CeLCVPofmli5w3EnOKqkOxZUuhduUKd
         VD85DAz74mTmjZ49Kp6ODkuYhr/02uzrnhDk43XIrOhUEYI+yMXUDDiXjtYFsxHt9xxb
         Zofw==
X-Forwarded-Encrypted: i=1; AJvYcCVy5UuBH6XLbW6RxMXp3RmKQon9Q6FHrmB1q/XHddOYHE9IyVVv84FjqBHRpy+xWEDQhkw0rMAkY0eyhusoVEU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8FckZT1AWV1P3zCYhwPQaT+6eRSRuj4A+6d+XD+i76q0iNaTT
	GDdmtQSKQYMWhnw8JL4qHVTxLonI9JAOresvrHb+9gwPmDFeDkZn/TZf
X-Gm-Gg: ASbGncuK2PyjZ18QCLc7kGvUMhBnQfRh4v/Oj6XI0bpnDAPGHCkhaE+iN5buJUlL5lp
	UZe1a34rGQLD+aHV5l50NhDey7vJiQetmPSk8ypmNW6PdL8uM209eUEsXYh+hVkPRbEhmtUl31w
	LQjfFIOWoPQsXyF0f4SeWgVSo0+GiBSo6Oh3WXG4OGNNxuo3skAP0wyHP2nD2ZUryfCssezbyXw
	nfN1SCXU2RcOFpomMgjPGTx2abcIUtOtQusdodlnIpyptkRKV4H0npmwO1uG9SD2KDlADzOytea
	J7blJTPE47zOv0iOvmGrooFB2yKMi6aReCvDo7LPluOaWXlFCL0t34sB/iaIJKUoxyd7jBH16BU
	AAx2ev6a8GpCwoXMSbczlg9Zn8MfmWS0/TPlwSzQ2WmqXOpIGNkknVxsarq+ir69C9jLgrh8+xO
	blX7LeFPqE
X-Google-Smtp-Source: AGHT+IFbTUe9F4h1LyVbUwgCQ1C/DV9vJaiYH1suq6bPPsdLXWTdUfcRVma8kaGj52ddQduYiLM0Cg==
X-Received: by 2002:a05:6a20:6a1e:b0:339:7f7c:bce5 with SMTP id adf61e73a8af0-33a9fb9f872mr2206937637.9.1761090431314;
        Tue, 21 Oct 2025 16:47:11 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:70::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a7664b30dsm11118178a12.7.2025.10.21.16.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:47:11 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 21 Oct 2025 16:46:56 -0700
Subject: [PATCH net-next v7 13/26] selftests/vsock: speed up tests by
 reducing the QEMU pidfile timeout
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-vsock-vmtest-v7-13-0661b7b6f081@meta.com>
References: <20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com>
In-Reply-To: <20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Reduce the time waiting for the QEMU pidfile from three minutes to five
seconds. The three minute time window was chosen to make sure QEMU had
enough time to fully boot up. This, however, is an unreasonably long
delay for QEMU to write the pidfile, which happens earlier when the QEMU
process starts (not after VM boot). The three minute delay becomes
noticeably wasteful in future tests that expect QEMU to fail and wait a
full three minutes for a pidfile that will never exist.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index d53dd25f5b48..020796e1c31a 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -22,7 +22,7 @@ readonly SSH_HOST_PORT=2222
 readonly VSOCK_CID=1234
 readonly WAIT_PERIOD=3
 readonly WAIT_PERIOD_MAX=60
-readonly WAIT_TOTAL=$(( WAIT_PERIOD * WAIT_PERIOD_MAX ))
+readonly WAIT_QEMU=5
 readonly PIDFILE_TEMPLATE=/tmp/vsock_vmtest_XXXX.pid
 
 # virtme-ng offers a netdev for ssh when using "--ssh", but we also need a
@@ -221,7 +221,7 @@ vm_start() {
 		--append "${KERNEL_CMDLINE}" \
 		--rw  &> ${logfile} &
 
-	timeout "${WAIT_TOTAL}" \
+	timeout "${WAIT_QEMU}" \
 		bash -c 'while [[ ! -s '"${pidfile}"' ]]; do sleep 1; done; exit 0'
 }
 

-- 
2.47.3


