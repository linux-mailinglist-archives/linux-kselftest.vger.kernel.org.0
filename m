Return-Path: <linux-kselftest+bounces-19608-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5866299B6A5
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Oct 2024 20:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A4461C20E17
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Oct 2024 18:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8482C84D2C;
	Sat, 12 Oct 2024 18:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sjbPXB58"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E72ECF;
	Sat, 12 Oct 2024 18:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728759042; cv=none; b=jM17JBGuIR33xJe6t1j4NGYyHtPMPGZ8mDH525tSWZCy3BDRb5YzjciEssusjA4djrhEdK1cYMxIn6nQc2Z1qw2BaoeUrcyhom9+I7aBTyIiDflTkGC+ln7GxNIypFQmCFfPKFh0+HbAGHL1nRDhegthjXB3/M7zUywZJ460/ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728759042; c=relaxed/simple;
	bh=xlyfFinpAIMxkhpzehswtzGSuOxBauq3EW60yF8W0KU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jSDjCPf1WxMCEnRxZG62MPkErlhrvHehqzUkogpg7SOJbE9qCiytaOg8omJlJc6NQn6aX6hbHhQO9+g+Xcxy09dq2WnCBQ9aSGIpr63zB3r8Zn2szHj6QjwNwRK36yWhmceaDBzemXF82UkE9oKYwE0vvpvCqp4MAk65eKE7XY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sjbPXB58; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=NdvDvCXdCRf5kKwdV4ILdoGwaCRgSKn3t9mg7Iye0cU=; b=sjbPXB58xP55zsB+GBhTRsDYvh
	TtENIjOc+QTGpVctDOCGZQtM3Cmlic4tJkwPBYbdezpwik5xmd/8VoSUWHRnZ32gWD1RTHz2dtf63
	vfdGd5WoN5WSzELwhZ1qo5FMbTtOAWZq/LdBHH/mwBh4/NUMPQxn0jJIJxbpiY7oT3eqLKmHN8865
	Cziv25W57ayRHOtYoUR7K4rtPcxO083uTRfMRCSk3IUW0XX3S+KGVnG5kIlJjeE94pLTaiOjspxY5
	1coUs8kGpEFCrRQM0T8gZp+mijL9KAtn5iskchtGjtm7sM+EGplZhyxs1LiFm3TaW8KcyIGkum+4B
	gfNQfozA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1szhCG-00000001g8H-40Ez;
	Sat, 12 Oct 2024 18:50:36 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: kdevops@lists.linux.dev
Cc: petr.pavlu@suse.com,
	samitolvanen@google.com,
	da.gomez@samsung.com,
	willy@infradead.org,
	liam.howlett@oracle.com,
	shuah@kernel.org,
	mricon@kernel.org,
	linux-modules@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	mcgrof@kernel.org
Subject: [PATCH kdevops] defconfig: add linux-modules-kpd defconfig symlink
Date: Sat, 12 Oct 2024 11:50:36 -0700
Message-ID: <20241012185036.400282-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

We have now two kdevops proof of concepts with kernel-patches-daemon [0],
one for Linux kernel modules testing [1] and the other with radix tree
testing (xarray, maple tree) [2]. These trees just contain the required
.github/workflows/* files used to trigger a github self-hosted runner
to run kdevops since evaluation shows that using github hosted runners
will just not work or scale for Linux kernel testing [3]. The way this
works with KPD is that KPD has an app in the linux-kdevops organization
which is in charge of taking patch series posted to your respective
subsystem patchwork (you can have dedicated filters on a mailing list
for only specific files if you don't have a dedicated mailing list), it
creates a git tree branch using your configured KPD main development
tree source, and pushes it out to a respective test tree under github
for for you. For example, in the case of development for Linux modules
it pushes out a branch with a delta onto the linux-modules-kpd tree [4]
and in it, it will also merge the latest kdevops-ci-modules [1] work,
which is where the github runner work gets developed. For the radix tree
we currently do not yet have a patchwork instance defined but we *could*,
and the way it would work is that KPD would push out a branch into
the linux-radix-tree-kpd [5] tree with the github actions defined in its
respective kdevops-ci-radix-tree [3] tree.

What these PoC shows is that the way kdevops has designed testing
selftests is that we actually only need to differ in *one* single line
of code on the github actions runner to test either of these two Linux
kernel subsystems: the defconfig used.

To be able to *share* the *same* Linux kernel github actions runner
code development between the Linux kernel module tests and the radix
tree, all we need to do then is use the git tree onto which a delta
was pushed onto as the source for the defconfig. So all we have to do
now is just add a symlink of the respective development test tree onto
its corresponding defconfig.

Add the respective defconfig then for linux-modules-kpd by symlinking it
to the seltests-kmod-cli defconfig. This will let us later share *one*
github development action runner code for self-hosted runners for *all*
Linux kernel sefltests we define in *one* development tree which KPD
could leverage.

Now that we have locked down the linux-kdevops github organization to
only allow respective developers to be able to trigger pushes or PRs,
this also allows us to add dedicated self-hosted runners per target
test development repository so we can scale our testing as we need with
security in mind. The only thing left to do here now, is to evaluate
if we want an allow check for who's patches we want to enable automatic
testing for through KPD.

[0] https://github.com/facebookincubator/kernel-patches-daemon
[1] https://github.com/linux-kdevops/kdevops-ci-modules
[2] https://github.com/linux-kdevops/kdevops-ci-radix-tree
[3] https://lore.kernel.org/kdevops/CAB=NE6VKWSkv1JZ_Z2LKq4o7+JBkKc6u8Wa1zxxBnGHOG4BgjA@mail.gmail.com/T/#u
[4] https://github.com/linux-kdevops/linux-modules-kpd
[5] https://github.com/linux-kdevops/linux-radix-tree-kpd
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 defconfigs/linux-modules-kpd | 1 +
 1 file changed, 1 insertion(+)
 create mode 120000 defconfigs/linux-modules-kpd

diff --git a/defconfigs/linux-modules-kpd b/defconfigs/linux-modules-kpd
new file mode 120000
index 000000000000..e61fd7f687b0
--- /dev/null
+++ b/defconfigs/linux-modules-kpd
@@ -0,0 +1 @@
+seltests-kmod-cli
\ No newline at end of file
-- 
2.43.0


