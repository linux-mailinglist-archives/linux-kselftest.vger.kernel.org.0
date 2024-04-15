Return-Path: <linux-kselftest+bounces-7987-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4CE8A5565
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 16:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF5C7B22BFA
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 14:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9E21EEE3;
	Mon, 15 Apr 2024 14:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YtBpYTUZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749BE2119
	for <linux-kselftest@vger.kernel.org>; Mon, 15 Apr 2024 14:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713192243; cv=none; b=gUz1/aTT5OZJ9vjwEh3MNWeI0SDTtyslrW4drzPKsrBMOhSbZodDovqZHmZL7t0ohM3DeSNCUmWQiDXo+pEFhs/mZHJBM/wUF+BltXkXO2gpTVE+RVR8S8Ttc7iytOgyllG219x+PUSMHcVFZNsYcxSgw9C3ZswCYmg/Q+SXjpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713192243; c=relaxed/simple;
	bh=KehpfQl+nFVwyeBbKTZT+XW0EbxiUmM5b6iOnH+si1k=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Q2As0NTxvowqKoq1m9n76RrP9oeZgALeM5QWtu0E3Vw0GogI/bZBhDFVMRXuxc/019p2u259C2RhVB5LwA4L9HjJl0a3ug2GwsLZneGEhelxPOTlwqfjOOjSJw8xRrN3ppIuSyMEsjSY2R5YiWtxId5lNKe1HavzsXRRXIoFArI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YtBpYTUZ; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4187fb76386so1105505e9.3
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Apr 2024 07:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713192241; x=1713797041; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0bmcD1dsKmxdOPG1Zb6XlpeF2OhOoXu9RprsqunU6bk=;
        b=YtBpYTUZMBbri/hmJ5zxlLFpf7YBqdISk+18XFkh+nFFjaeOsNfXfLmswIdU8UnoTh
         EVO8YaKQSjN3PFoQNbplnaPRLqFMAR3mrmU8WaDBB+TDSxrbTZIAk+8jm1sj3fG6WItn
         j7V70Y2siCesj6mcdo187WBOJrcfVLu4RfImvEve8vkia11SQLFgUvV32fU1n++XMpj1
         oiHeYUG6mt5rVtjF8hkj7RHxl6pZCMOrlkUDvT47lP0WcXqc9XXygNmry8PUyPOSO6wk
         iJckUWhfXJazU5/LGqfFaj0pjm5gL+ideoyXozsAfhCDwzmMtTVaADokMjOtxEwRHdJu
         pV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713192241; x=1713797041;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0bmcD1dsKmxdOPG1Zb6XlpeF2OhOoXu9RprsqunU6bk=;
        b=NWmlNRIr68wnxmpFrKXESh0pYS5/HXssHTuc8V7Mo7/uykq/uSoAuRGapXAdddMpon
         cpKfAGPRs1tLMdtm8YMjzQHeg2EBZQXkeWKdFIy7KTKrz/PK2G2IEHcIpn7ZJhwVcpqP
         tCq+BgURiCFNro+xhvK/Gt65kNTN3gpAzbC48o2aSmdInSu6+j3Mev9a00Qg9xjFvgl/
         0462039nlprOwVsBzN93EIJ33RUJQvhnHQtEC+d2cYgLNG0U1YoIVVZuj/F6HCR0AsCi
         3EyjFzaYf9XF/SBPQYiSPGqALJ/e+aV/RcdvAbvZCirmpz2fRcuGT9o0BpCN//O5GFxf
         NNnA==
X-Forwarded-Encrypted: i=1; AJvYcCU6LiWi06yzZl0h4UPctx6GFo8s8Yb2jd8TWvYqnG1QgmYNRY3+bEjqF8eE/0VagRARVGo8lrgfFQrV2GwyKiSIPvtnzxpIk9maoFCjutOg
X-Gm-Message-State: AOJu0Yz5kICDeol+jarb4CRBpco6faHY1VqNpElCbkYjLV6q8gwJxNcd
	6mv7w294xYCGXShXHT2nhHaLX2DwWDJ0YFA9BU1/aGfWo4Ip+wk5eWNQZIxhHOz3HJyQXw6Sen2
	eZwkpL2EV7w==
X-Google-Smtp-Source: AGHT+IFEmFS1HiEMaFINlIUIUMR/6wAm50IL2RKmWT9wBF0Ao1Ak+ndSv5qjpwOV71WeC8xHyrbagpOvd2bt2Q==
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a05:600c:458d:b0:416:a53f:38fd with SMTP
 id r13-20020a05600c458d00b00416a53f38fdmr32504wmo.1.1713192240874; Mon, 15
 Apr 2024 07:44:00 -0700 (PDT)
Date: Mon, 15 Apr 2024 14:43:54 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIACk9HWYC/x3MQQqAIBBA0avErBtIS5CuEi2ixhoqDackiO6et
 HyL/x8QikwCbfFApMTCwWeosoBxGfxMyFM26Eo3VaMMrmlHoc2dJKegDyjXFFANxjhbK2ethtw ekRzf/7fr3/cDxrlkFWcAAAA=
X-Mailer: b4 0.14-dev
Message-ID: <20240415-kvm-selftests-no-sudo-v1-1-95153ad5f470@google.com>
Subject: [PATCH] KVM: selftests: Avoid assuming "sudo" exists
From: Brendan Jackman <jackmanb@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

I ran into a failure running this test on a minimal rootfs.

Can be fixed by just skipping the "sudo" in case we are already root.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.sh | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.sh b/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.sh
index 7cbb409801eea..0e56822e8e0bf 100755
--- a/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.sh
+++ b/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.sh
@@ -13,10 +13,21 @@ NX_HUGE_PAGES_RECOVERY_RATIO=$(cat /sys/module/kvm/parameters/nx_huge_pages_reco
 NX_HUGE_PAGES_RECOVERY_PERIOD=$(cat /sys/module/kvm/parameters/nx_huge_pages_recovery_period_ms)
 HUGE_PAGES=$(cat /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages)
 
+# If we're already root, the host might not have sudo.
+if [ $(whoami) == "root" ]; then
+	function maybe_sudo () {
+		"$@"
+	}
+else
+	function maybe_sudo () {
+		sudo "$@"
+	}
+fi
+
 set +e
 
 function sudo_echo () {
-	echo "$1" | sudo tee -a "$2" > /dev/null
+	echo "$1" | maybe_sudo tee -a "$2" > /dev/null
 }
 
 NXECUTABLE="$(dirname $0)/nx_huge_pages_test"

---
base-commit: 2c71fdf02a95b3dd425b42f28fd47fb2b1d22702
change-id: 20240415-kvm-selftests-no-sudo-1a55f831f882

Best regards,
-- 
Brendan Jackman <jackmanb@google.com>


