Return-Path: <linux-kselftest+bounces-5440-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA118679E3
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Feb 2024 16:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94B731F305CE
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Feb 2024 15:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1796E130E37;
	Mon, 26 Feb 2024 15:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YFlirN4t";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="osXp16o2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC1B130AD7
	for <linux-kselftest@vger.kernel.org>; Mon, 26 Feb 2024 15:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708960275; cv=none; b=Z096tsxWPI5/Tc7khd6UPso6F6g8uEWX7BSpb7oV9vhmh5hdM2PTWSj5V2Vkud8USqX2biIlfWyg1zoaLssmd9E8YmmUH9KJUVhTaQuE6fVXQ7C50qgVkqXqH6O+AYghRlx9tObr8UAAfXhhETcG1C3iLzT+EeD+Jww7znVL+F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708960275; c=relaxed/simple;
	bh=QMqxmVnBlqgd8i8PUjIsEy2rUcnjR9M6n1w80RURmsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gIT2X3ywZRUSnEYw4xAGhrdMg0FzjPM2B1pKkl9CzSGBLBYpbSrmobODwG/ZiKk3lPGLW4hKI0FqXu3ksmYOCNx0zBqMHzegMVpgFdHAVdHmrid22L4CwA83mUG27+s6f7iD/EeQYLkN9mvblPR9eM9WzTi9niaztY9vytvAnM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YFlirN4t; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=osXp16o2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 34480225BD;
	Mon, 26 Feb 2024 15:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708960271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dRLEm3blJW2MUUlMTjXImwYPQkg7IRThtpm8+2Ddju8=;
	b=YFlirN4txHjNaPHqGfwkwj2RdBuxTICmw62zYxJupWup4Zv4F2N/cUx25eZmlJd0Gb0en/
	bVX8YkQvqMxip6shmMvTfoFZDwUTJzISWScAEpYFoc7FS4dMQJLQijaGyMCfKJoIXQmDds
	q4sDyFTHdGBqWx3NoAdP15VwR6ktMe8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708960270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dRLEm3blJW2MUUlMTjXImwYPQkg7IRThtpm8+2Ddju8=;
	b=osXp16o2YYGJC0ov9CI4vqLFK0D2DtG20gQJUyWITN4olp+yBrFnTm1u1r9HBDPWENFnjJ
	CcimdeIygcHg37hOMjaircwLs50Sn5Tt0kIYwfEmTM3mnIHs4FOThoAkBzKPx8xMZ3WJt0
	9/nw5Vlp01Zgd8GTEdoq3dzAGwubVxI=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B640F13A43;
	Mon, 26 Feb 2024 15:11:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id VpCIHw2q3GVnawAAn2gu4w
	(envelope-from <mpdesouza@suse.com>); Mon, 26 Feb 2024 15:11:09 +0000
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: "kernelci.org bot" <bot@kernelci.org>
Cc: kernelci-results@groups.io,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org
Subject: Re: kselftest/next kselftest-livepatch: 1 runs, 1 regressions (v6.8-rc1-53-gae638551ab64a)
Date: Mon, 26 Feb 2024 12:11:05 -0300
Message-ID: <20240226151106.3256-1-mpdesouza@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <65d985d0.630a0220.5f483.15a6@mx.google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=osXp16o2
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.51 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[kernelci.org:url,kernelci.org:email,suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -1.51
X-Rspamd-Queue-Id: 34480225BD
X-Spam-Flag: NO

On Fri, 23 Feb 2024 21:59:44 -0800 (PST) "kernelci.org bot" <bot@kernelci.org> wrote:

> kselftest/next kselftest-livepatch: 1 runs, 1 regressions (v6.8-rc1-53-gae638551ab64a)
> 
> Regressions Summary
> -------------------
> 
> platform        | arch | lab           | compiler | defconfig                    | regressions
> ----------------+------+---------------+----------+------------------------------+------------
> imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+kselftest | 1          
> 
>   Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.8-rc1-53-gae638551ab64a/plan/kselftest-livepatch/
> 
>   Test:     kselftest-livepatch
>   Tree:     kselftest
>   Branch:   next
>   Describe: v6.8-rc1-53-gae638551ab64a
>   URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git
>   SHA:      ae638551ab64a216364a63c4ee5061f82702fde2 
> 
> 
> Test Regressions
> ---------------- 
> 
> 
> platform        | arch | lab           | compiler | defconfig                    | regressions
> ----------------+------+---------------+----------+------------------------------+------------
> imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+kselftest | 1          
> 
>   Details:     https://kernelci.org/test/plan/id/65d97ac95e7438716b637012
> 
>   Results:     1 PASS, 1 FAIL, 0 SKIP
>   Full config: multi_v7_defconfig+kselftest
>   Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 20210110)
>   Plain log:   https://storage.kernelci.org//kselftest/next/v6.8-rc1-53-gae638551ab64a/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-livepatch-imx6q-sabrelite.txt
>   HTML log:    https://storage.kernelci.org//kselftest/next/v6.8-rc1-53-gae638551ab64a/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-livepatch-imx6q-sabrelite.html
>   Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-kselftest/20240129.0/armhf/initrd.cpio.gz 
> 
> 
>   * kselftest-livepatch.shardfile-livepatch: https://kernelci.org/test/case/id/65d97ac95e7438716b637014
>         failing since 9 days (last pass: v6.8-rc1, first fail: v6.8-rc1-32-g345e8abe4c355)
> 
>     2024-02-24T05:18:03.496498  / # 
> 
>     2024-02-24T05:18:03.506371  
> 
>     2024-02-24T05:18:08.651646  / # export NFS_ROOTFS='/var/lib/lava/dispatcher/tmp/12846770/extract-nfsrootfs-_kckc7kq'
> 
>     2024-02-24T05:18:08.665764  export NFS_ROOTFS='/var/lib/lava/dispatcher/tmp/12846770/extract-nfsrootfs-_kckc7kq'
> 
>     2024-02-24T05:18:10.892206  / # export NFS_SERVER_IP='192.168.201.1'
> 
>     2024-02-24T05:18:10.903149  export NFS_SERVER_IP='192.168.201.1'
> 
>     2024-02-24T05:18:11.021855  / # #
> 
>     2024-02-24T05:18:11.030274  #
> 
>     2024-02-24T05:18:11.147792  / # export SHELL=/bin/bash
> 
>     2024-02-24T05:18:11.158106  export SHELL=/bin/bash
>  
>     ... (121 line(s) more)  
>   


Is there a way to check this locally? How this teseting image is generated? I would like
to check if there is something that we need to fix on the livepatch selftests.

Thanks,
  Marcos

