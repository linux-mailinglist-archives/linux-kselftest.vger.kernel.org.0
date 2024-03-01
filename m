Return-Path: <linux-kselftest+bounces-5711-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5173886E0D2
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 13:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D265C1F22EA6
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 12:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA7F6CDB8;
	Fri,  1 Mar 2024 12:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="EqlNMx0b";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="EqlNMx0b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBC279F1
	for <linux-kselftest@vger.kernel.org>; Fri,  1 Mar 2024 12:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709294754; cv=none; b=orAqKZRuINjZdPagsi+AwbPYyE9hlenF4hxpQu5chTg2XE6YRTzY+N4/6pY8ezNV/PHn2luYeNFC5GN7NJDlEyLKVA5LHllsMtUha3pZR+426NlTENGk1QdNwt/3wKAggoK6M4RrpmS2Fl7q4vYyHhkDnBb8uhZ/iCUrAL8nI3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709294754; c=relaxed/simple;
	bh=GT8RvPXzpQbNAr+PmwPafqn4JlsxEiG09hLNrTVSe7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dJxHvdDOCo4lkXbSDGM6Nsugg/pvcy6flKFhuAzHGOBCxdSdTKREgx5FM2GHXfw+BQkNjH3CaqyemOmWFNg/Ctnts1fgxxj9PMXQmsxxTUs4ssw4pMBrnmr2PVwuW+d3HinB8/3B57lfMvvSC37e3LmY8F2otiMfJnxibLJn3js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=EqlNMx0b; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=EqlNMx0b; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AC9791F867;
	Fri,  1 Mar 2024 12:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709294750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WH0PIa1AAXQf6SoL4FRmNRLcMSTmCWq1NW3frVdcIjw=;
	b=EqlNMx0bulitP8tUYoheeLOINYf1lslQNSVr/b/aUPTkYb89LrH0qQEzkfk4i4rxOX9VRP
	1/75ACR80d/EKc7FHCFtnrE0NU0858zohW258rkExVEOTVadtQ5BIbnoh6TJW4M8+qATaS
	Ip6zBOG4yXSag48izezOWtU0uqWkezg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709294750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WH0PIa1AAXQf6SoL4FRmNRLcMSTmCWq1NW3frVdcIjw=;
	b=EqlNMx0bulitP8tUYoheeLOINYf1lslQNSVr/b/aUPTkYb89LrH0qQEzkfk4i4rxOX9VRP
	1/75ACR80d/EKc7FHCFtnrE0NU0858zohW258rkExVEOTVadtQ5BIbnoh6TJW4M8+qATaS
	Ip6zBOG4yXSag48izezOWtU0uqWkezg=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 39B2013581;
	Fri,  1 Mar 2024 12:05:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id ODPYAJ7E4WWDPgAAn2gu4w
	(envelope-from <mpdesouza@suse.com>); Fri, 01 Mar 2024 12:05:50 +0000
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: "kernelci.org bot" <bot@kernelci.org>,
	kernelci-results@groups.io,
	linux-kselftest@vger.kernel.org,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	shuah@kernel.org
Subject: Re: kselftest/next kselftest-livepatch: 1 runs, 1 regressions (v6.8-rc1-56-g539cd3f4da3f)
Date: Fri,  1 Mar 2024 09:05:44 -0300
Message-ID: <20240301120545.15733-1-mpdesouza@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <a304f03b-7b2d-4c6d-9c11-4f4b1cda589c@linuxfoundation.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=EqlNMx0b
X-Spamd-Result: default: False [0.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 DWL_DNSWL_LOW(-1.00)[suse.com:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 0.69
X-Rspamd-Queue-Id: AC9791F867
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On Wed, 28 Feb 2024 15:28:14 -0700 Shuah Khan <skhan@linuxfoundation.org> wrote:

> On 2/28/24 00:21, kernelci.org bot wrote:
> > kselftest/next kselftest-livepatch: 1 runs, 1 regressions (v6.8-rc1-56-g539cd3f4da3f)
> > 
> > Regressions Summary
> > -------------------
> > 
> > platform        | arch | lab           | compiler | defconfig                    | regressions
> > ----------------+------+---------------+----------+------------------------------+------------
> > imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+kselftest | 1
> > 
> >    Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.8-rc1-56-g539cd3f4da3f/plan/kselftest-livepatch/
> > 
> >    Test:     kselftest-livepatch
> >    Tree:     kselftest
> >    Branch:   next
> >    Describe: v6.8-rc1-56-g539cd3f4da3f
> >    URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git
> >    SHA:      539cd3f4da3fdbe7dc353634e004e4b0e725c35a
> > 
> > 
> > Test Regressions
> > ----------------
> > 
> > 
> > platform        | arch | lab           | compiler | defconfig                    | regressions
> > ----------------+------+---------------+----------+------------------------------+------------
> > imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+kselftest | 1
> > 
> >    Details:     https://kernelci.org/test/plan/id/65ded1d5c2aa34249963703c
> > 
> >    Results:     1 PASS, 1 FAIL, 0 SKIP
> >    Full config: multi_v7_defconfig+kselftest
> >    Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 20210110)
> >    Plain log:   https://storage.kernelci.org//kselftest/next/v6.8-rc1-56-g539cd3f4da3f/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-livepatch-imx6q-sabrelite.txt
> >    HTML log:    https://storage.kernelci.org//kselftest/next/v6.8-rc1-56-g539cd3f4da3f/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-livepatch-imx6q-sabrelite.html
> >    Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-kselftest/20240129.0/armhf/initrd.cpio.gz
> > 
> > 
> >    * kselftest-livepatch.shardfile-livepatch: https://kernelci.org/test/case/id/65ded1d5c2aa34249963703e
> >          failing since 13 days (last pass: v6.8-rc1, first fail: v6.8-rc1-32-g345e8abe4c355)
> > 
> >      2024-02-28T06:26:05.757140  / #
> > 
> >      2024-02-28T06:26:05.767314
> > 
> >      2024-02-28T06:26:10.908349  / # export NFS_ROOTFS='/var/lib/lava/dispatcher/tmp/12885469/extract-nfsrootfs-c33w8jjk'
> > 
> >      2024-02-28T06:26:10.925782  export NFS_ROOTFS='/var/lib/lava/dispatcher/tmp/12885469/extract-nfsrootfs-c33w8jjk'
> > 
> >      2024-02-28T06:26:13.149970  / # export NFS_SERVER_IP='192.168.201.1'
> > 
> >      2024-02-28T06:26:13.161626  export NFS_SERVER_IP='192.168.201.1'
> > 
> >      2024-02-28T06:26:13.280972  / # #
> > 
> >      2024-02-28T06:26:13.289584  #
> > 
> >      2024-02-28T06:26:13.405920  / # export SHELL=/bin/bash
> > 
> >      2024-02-28T06:26:13.417269  export SHELL=/bin/bash
> >   
> >      ... (112 line(s) more)
> >    
> 
> Hi Marco,
> 
> Please take a look at this regression. I applied your patch
> series that fixed the problems found in o-day bot. Is this
> a different problem?

Hi Shuah,

I've sent a question to Usama Anjum a couple days ago about it, and he answered
that this issue is not a test problem, but their setup's fault.

thanks,
  Marcos

> 
> thanks,
> -- Shuah

