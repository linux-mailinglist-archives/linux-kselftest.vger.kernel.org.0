Return-Path: <linux-kselftest+bounces-42326-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB5BB9FAE2
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 15:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D5051C23674
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 13:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9377328689C;
	Thu, 25 Sep 2025 13:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLJWKHAG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208E0286897
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 13:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758808453; cv=none; b=FKXZJvfk1igtCK83WdJsyt/WyJ6m9h2D/Xo5YvW9tWHup8GU4uios4mB4IQKTNIr7Nifeb+a3zrfqFTzJcly5J552x+7zRO4qOQVWYqm6IQri6KNTxlkU9rRCr+Mj8aDIG+gpXMZ3loXgdMtUulteyRblA0VuKKXUfL9ODPs3fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758808453; c=relaxed/simple;
	bh=GEMmqrP/RK6YlUrlIRTRGi0wnwQ4oY7ol2RY5xlPCRg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qouRK59dsESTc279XPzi4jE6LKy89WRhBLFtCfUtxRuSsEjM/T6Gyhvzd9oGEN0woG2Ui83jUDevFq3wRJ+hTj7GALRd24leN/ntNwqEnlUwFvVBakLsL05FPHY63TaN2Zal9eHz9iFTDowV9Xcw3WMdsh6nbiPHm7fyADVJre0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLJWKHAG; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-796d68804a0so10051406d6.3
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 06:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758808450; x=1759413250; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nN1kM5+gletp/n333+wlIxoZSFpVAQ/wESePzoHRX5k=;
        b=JLJWKHAGUWUD5n+daBh1yvQGe+dkjXTvaQXgJ1gmVtp4/mSWBBVvDEvDZOsH14YnrZ
         +4I9IX/aidqSUCt3sibrJFJnr0RwxqLxgzAt4VEEacDZZO4O1Laf+tOX3G4V4cTfBPCw
         bjIP9BOOzDaNXyOUAKYNmgyM4L0E1MZFIuDEO2bj/sH2avsvDJezLh0N+lPD9a19jzxK
         yeY5HNqR8L6Yhoy+/Q6rEcpPf+JC9Qdfdr4/64oDMBqyByZAAmlntiaPfXZP5ATtOjbV
         ojxH2IetDyfVotGuZXPMhb6N6WVjDG3PPc6Pzu2FZVXLnpUdRLsdHuzlUyEPnlmgoLK9
         pvHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758808450; x=1759413250;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nN1kM5+gletp/n333+wlIxoZSFpVAQ/wESePzoHRX5k=;
        b=kXamC8TB3F/jRoFaTeemjpP5oMHr9ZnyKST3Bsi+Xnfok2iidG0Vt9nxTuRd9Kztw0
         cbdYyhlS3n25COUaJySH4sSv8YSICVI7QeN5WZwrUcPoMHu9L/Q/V6XgiKyrXO+kKP4b
         FxqXKE5UHQqv+dUWbUJPJj9pSzh1fXHRqWP6EQXtXSbpwuqs0jhUsqTArtylvlP5o5UT
         SXLdex7IYq9whDnS4TZOikpolp+5a/qduNZiFb9eyFMZzbco4v4BCFp3zzFzIS262jDq
         pRDqiIHNUsDo+i7NZHS2ZU4xd1IHfClCrApKmiZIKYHISFKgf3ERjaaOxjK/Bsg4XKM0
         4okg==
X-Forwarded-Encrypted: i=1; AJvYcCV5zdqGcPmK2YYZmfBoXAJoAKTPGTO4QnVz9J6E8iwNPJnhpv3g+PeSkU9ckaNMGrh4xEl2JVBSKWcapwVzsPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YznQWibytrXRSwylyIGoVYfuAGWfrdGUv25SKC7LZDQJlOycKNh
	snLSpkPI4vrc3Uv+Go8YyzYYBNk68wMiNyotrltA+2foWhhLzNIIWpb+
X-Gm-Gg: ASbGnctGIrg1OBzmloAwWi9kXCC+JM5MkSWv718ZYktVFDl9KuHzGQyY0ozqFWwoAvy
	+cFI5GvDVCcBygci6Ow/bIELItK/kgwdVtiuVHtwKlvyUPpLMaYQKfvgkGCl2LWb1N7LwsZPO+A
	vBXtCIxfuOLycYfw8cLi3ttMK0D3UCE1S2tBSCwVs4wOJ5IIZnDlM7iIbfho9E6sqlStQ1VHWl0
	FeNyRzGxg65fw61cNj2ognou46EznXQlRYJSaT9ZNZWbRs0pf7ASUZT8vTlcadFuoyLmLCcqYIC
	4QwN4uTE782hYQ4kORk00cNYN5jWs6055f3/I7VTZzWuW44RZAAYY3bYkrOspvfqMAXIOuBaR7Z
	/dCLn+TpbP51o2seWstLaPp5FYi3n3TMtpn70nf+R33v4e52Tg0kAnIq104OsgPpr4IEQdw8keC
	7MUXa3RsdTiZmRDI+dYc7Seo4Q/7UqfjCHXI1CAdGKCl2acCrNqeP+yn0gvA/CVAOzVkNH
X-Google-Smtp-Source: AGHT+IG8iotWiF9WZ9QNmLnrLYD4Bm/T3WD/aC7e1ZFkIy8L1i0Vs2M7Ocbk3KWdS/5CartACRQexA==
X-Received: by 2002:a05:6214:258a:b0:80f:517d:2647 with SMTP id 6a1803df08f44-80f517d27e1mr14445326d6.22.1758808449532;
        Thu, 25 Sep 2025 06:54:09 -0700 (PDT)
Received: from 137.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:7c:b286:dba3:5ba8])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-80135968d5esm11536916d6.12.2025.09.25.06.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 06:54:08 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v2 00/19] rust: replace `kernel::c_str!` with C-Strings
Date: Thu, 25 Sep 2025 09:53:48 -0400
Message-Id: <20250925-core-cstr-cstrings-v2-0-78e0aaace1cd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG1J1WgC/32PzU7EMAyEX6XKmSA7SV3aE++B9pAfpxuJtktSK
 tCq707a5cCJi6WxNDPf3EXhnLiIobmLzFsqaZmrUE+N8Fc7jyxTqFooUC10CNIvmaUvaz5Pmsc
 iMVprSasIMYhqvGWO6esMfbs8dOaPz5q9Pp7C2VJDlmlK69BEHclpIqNBMRJH9OR6BG1sp0JsW
 zKB3IsVf5kq4kGkAH9hDqxgXO+oRwU+DhuSONqvqaxL/j4XbnjW/zdmQwkSVGcUsO36nl/Hyab
 350orLvu+/wD88s8sMgEAAA==
X-Change-ID: 20250710-core-cstr-cstrings-1faaa632f0fd
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Breno Leitao <leitao@debian.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Jens Axboe <axboe@kernel.dk>, Alexandre Courbot <acourbot@nvidia.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1758808436; l=3853;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=GEMmqrP/RK6YlUrlIRTRGi0wnwQ4oY7ol2RY5xlPCRg=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QO/26UCYVrC1IViagcUS26Xk65Ejp4ZjzAzAyQQVar2N9GQH7mgOjszrNtLW6r94x8eZkRa/Pgk
 CZf+Ko+eviwM=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

This series depends on step 3[0].

Subsystem maintainers: I would appreciate your `Acked-by`s so that this
can be taken through Miguel's tree (where the previous series must go).

Link: https://lore.kernel.org/all/20250925-cstr-core-v16-0-5cdcb3470ec2@gmail.com/ [0]

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Changes in v2:
- Rebase.
- Add two patches to address new code.
- Drop incorrectly applied Acked-by tags from Danilo.
- Link to v1: https://lore.kernel.org/r/20250710-core-cstr-cstrings-v1-0-027420ea799e@gmail.com

---
Tamir Duberstein (19):
      drivers: net: replace `kernel::c_str!` with C-Strings
      gpu: nova-core: replace `kernel::c_str!` with C-Strings
      rust: auxiliary: replace `kernel::c_str!` with C-Strings
      rust: clk: replace `kernel::c_str!` with C-Strings
      rust: configfs: replace `kernel::c_str!` with C-Strings
      rust: cpufreq: replace `kernel::c_str!` with C-Strings
      rust: device: replace `kernel::c_str!` with C-Strings
      rust: firmware: replace `kernel::c_str!` with C-Strings
      rust: kunit: replace `kernel::c_str!` with C-Strings
      rust: macros: replace `kernel::c_str!` with C-Strings
      rust: miscdevice: replace `kernel::c_str!` with C-Strings
      rust: net: replace `kernel::c_str!` with C-Strings
      rust: pci: replace `kernel::c_str!` with C-Strings
      rust: platform: replace `kernel::c_str!` with C-Strings
      rust: seq_file: replace `kernel::c_str!` with C-Strings
      rust: str: replace `kernel::c_str!` with C-Strings
      rust: sync: replace `kernel::c_str!` with C-Strings
      rust: io: replace `kernel::c_str!` with C-Strings
      rust: regulator: replace `kernel::c_str!` with C-Strings

 drivers/block/rnull.rs                |  2 +-
 drivers/cpufreq/rcpufreq_dt.rs        |  5 ++---
 drivers/gpu/drm/nova/driver.rs        | 10 +++++-----
 drivers/gpu/nova-core/driver.rs       |  6 +++---
 drivers/net/phy/ax88796b_rust.rs      |  7 +++----
 drivers/net/phy/qt2025.rs             |  5 ++---
 rust/kernel/clk.rs                    |  6 ++----
 rust/kernel/configfs.rs               |  9 +++++----
 rust/kernel/cpufreq.rs                |  3 +--
 rust/kernel/device.rs                 |  4 +---
 rust/kernel/device/property.rs        |  6 +++---
 rust/kernel/firmware.rs               |  6 +++---
 rust/kernel/io/mem.rs                 |  7 +++----
 rust/kernel/kunit.rs                  | 11 ++++-------
 rust/kernel/net/phy.rs                |  6 ++----
 rust/kernel/platform.rs               |  6 +++---
 rust/kernel/regulator.rs              |  9 +++------
 rust/kernel/seq_file.rs               |  4 ++--
 rust/kernel/str.rs                    |  5 ++---
 rust/kernel/sync.rs                   |  5 ++---
 rust/kernel/sync/completion.rs        |  2 +-
 rust/kernel/workqueue.rs              |  8 ++++----
 rust/macros/kunit.rs                  | 10 +++++-----
 rust/macros/module.rs                 |  2 +-
 samples/rust/rust_configfs.rs         |  5 ++---
 samples/rust/rust_driver_auxiliary.rs |  4 ++--
 samples/rust/rust_driver_faux.rs      |  4 ++--
 samples/rust/rust_driver_pci.rs       |  4 ++--
 samples/rust/rust_driver_platform.rs  | 30 ++++++++++++++----------------
 samples/rust/rust_misc_device.rs      |  3 +--
 scripts/rustdoc_test_gen.rs           |  4 ++--
 31 files changed, 88 insertions(+), 110 deletions(-)
---
base-commit: f3f6b3664302e16ef1c6b91034a72df5564d6b8a
change-id: 20250710-core-cstr-cstrings-1faaa632f0fd
prerequisite-change-id: 20250201-cstr-core-d4b9b69120cf:v16
prerequisite-patch-id: e0ca756f740ab0ce7478bbf6510948ba89529a2f
prerequisite-patch-id: 6d8dbdf864f79fc0c2820e702a7cb87753649ca0
prerequisite-patch-id: 7d4d1d036043a85dcbaf0d09ea85768120efe094

Best regards,
--  
Tamir Duberstein <tamird@gmail.com>


