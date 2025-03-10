Return-Path: <linux-kselftest+bounces-28649-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12129A599B8
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 16:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D589216EA6E
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 15:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4E422DFB4;
	Mon, 10 Mar 2025 15:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="r5qPsxO7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89801A5B9F
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Mar 2025 15:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741619884; cv=none; b=mdMCraGWrONCdaUw0B2K8v52N7Ed10V7baluTG9unpcm7+OmVR6sGpmdZRccM4EAyuYX3grH4dvGUy8oVdonIEv+J7moJmcDS3t9+Qol3kyTG5brmRGxfymcg+RBcTFgnN2oVWuYe0t96m+oaRCDl+1KJl5bH+JrXfQc2GsfI68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741619884; c=relaxed/simple;
	bh=bPylOSDwS97iSZCV+IEqBXVcR6T1dmvHZUxK1IgpS9E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=si3zYqaTl4+z80tQ49x2sPkFjNvEat8jXcniaKRvaczjJjz3uvMZ2QsXsjweqszMeM4D073ir1Of/0YEGjPAqThPBd/KHgHnD/SkX93wJd9orrsMio5S8fzqtlC3YVvpEtO4cpqwaN7HEX8kY+Qis4aVxYdQMjrp9KThEVy8KG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=r5qPsxO7; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3cf82bd380bso36530595ab.0
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Mar 2025 08:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741619882; x=1742224682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJONlHZ+GagU256YR9i4k/iT8kbk8lsmHf8ZZIFoi8U=;
        b=r5qPsxO7zJjb+EM2lDGjAycLC07ZTQ3KOufDZU5/3eB465ILeo7DWNujMbDJhvQQ6n
         jhzTe9FXDgfwQQ3pxtyFRDpzOFDOz8Axs8aOD0rQ92E/VSLJ0MswlVCNFfmVpnkCoy6r
         FyoGUy/rTJGsytx/Yb0R8ccWKR8rwATbZ0ocqSE8aHz37TKA71Gm019PsHJUzW0wRnHE
         vZn/VhmfKAg7o34DaHTtansori9mttCQHRrP1vzJ1Fh7aMiynUqdcCSnEN34rA8tEbJc
         IeK+FIDO3Bz99UP3i1l7LYl6/ZNC39sj7/l0j6CMW6v20wcO+bVxonG+cTjPpboQ9wen
         24pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741619882; x=1742224682;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sJONlHZ+GagU256YR9i4k/iT8kbk8lsmHf8ZZIFoi8U=;
        b=BC3pDdEObpsIzxyPdFFrg+yESbNwC81vKck8ZDZvI6lA4uT/iAdvVtCFClc00W35FC
         pq/rznV31P+4Rvd51ToiaQE59k8kOcwUviNJ10o69LWdkWb9NhWXRxWY5JQi7yC+3jlY
         3YkecFXKVrWkDbniveUgnjNqPMzkjDkNIZWI5mR4SNjS7x1y6ca1sD7SrPMaImT/JZYU
         e3iZjt5aBRlkvZoHPioAkQgXOXI0c0PH0k6ZY9cGIRa/WFYE4zxBkOAnuHZE2gCufISm
         cJzYmXrn3luwEA5EVJ2ZsS0wWs/4hqEcMiCvAoz8eCTY+kMn4izWrNGEHZtlGcIolw3t
         2/1g==
X-Gm-Message-State: AOJu0YzSTUMG3sJ4do9cAq2sfdsHSaX3xH5OofQ3LFcsJGKbgYQ1sD0M
	lAtDQdzlg+bx/as5QY8T4k2Dkw7CDAjJAxHqtPLM2ngr/5zQAi6rAbD76baAuYQ=
X-Gm-Gg: ASbGncuFlb02GVxWOFDNUskZldAxAu8ieorbptHnbxYHTzqCcnmCGr2+AU9zmuSsM9P
	NO5Yv2XURjUxH7z5pWy6XYAe9SvsR0kCoQYO0j57uLVv4LmxxActMVPuyDJQs4xNQLj7gwjwDJa
	9wRvWpLEIezPCHblYMrpDy18hyhT5Yza4cxi8GZvo1oGICyjM3S3fVH6YgeFTlcUh03mHaB/i9P
	RC/YBXliBAxBr2dpaYy80enCyCqMbUS7oit1aNCX4my09n2lXbPqqWa7/6FRAsWJ9LJp6cUIKIo
	oC26/7e3axURYusHLaYDfkYzkCyFUtljpXk=
X-Google-Smtp-Source: AGHT+IHv9VsH6yBvvTt1jAq7zvObqCkXqipABSruyTT1k4fmXx9mvK0swA53Jk2vVY8Ndp7VAb1ADg==
X-Received: by 2002:a05:6e02:1b0a:b0:3d0:4a82:3f43 with SMTP id e9e14a558f8ab-3d46890d179mr1277075ab.5.1741619881935;
        Mon, 10 Mar 2025 08:18:01 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d459e2377asm6121355ab.31.2025.03.10.08.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 08:18:01 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: linux-kselftest@vger.kernel.org
In-Reply-To: <20250303124324.3563605-1-ming.lei@redhat.com>
References: <20250303124324.3563605-1-ming.lei@redhat.com>
Subject: Re: [PATCH 00/11] selftests: ublk: bug fixes & consolidation
Message-Id: <174161988103.195912.1952372188242377031.b4-ty@kernel.dk>
Date: Mon, 10 Mar 2025 09:18:01 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Mon, 03 Mar 2025 20:43:10 +0800, Ming Lei wrote:
> This patchset fixes several issues(1, 2, 4) and consolidate & improve
> the tests in the following ways:
> 
> - support shellcheck and fixes all warning
> 
> - misc cleanup
> 
> [...]

Applied, thanks!

[01/11] selftests: ublk: make ublk_stop_io_daemon() more reliable
        commit: 9894e0eaae980df1ed3f2e86a487fe4c8ef1ab46
[02/11] selftests: ublk: fix build failure
        commit: 9d80f48c5e08b2e003e506c6e5326a35a652ea2f
[03/11] selftests: ublk: add --foreground command line
        commit: 2ecdcdfee58c028c15ed00b691104249370db075
[04/11] selftests: ublk: fix parsing '-a' argument
        commit: cf2132935639813a0b88e55074e6e52a4b82f26a
[05/11] selftests: ublk: support shellcheck and fix all warning
        commit: 30aab83035048c70e09ff058a73e8428de9bd103
[06/11] selftests: ublk: don't pass ${dev_id} to _cleanup_test()
        commit: 8da9f88fee59fe5aa99014a2621b07347edd5780
[07/11] selftests: ublk: move zero copy feature check into _add_ublk_dev()
        commit: b95b47eaa8d7c8b595d93397d1b85f1559c2d220
[08/11] selftests: ublk: load/unload ublk_drv when preparing & cleaning up tests
        commit: 9e71305495d1b79f96729b8d77d4d823a6bd998a
[09/11] selftests: ublk: add one stress test for covering IO vs. removing device
        commit: 6f3004e78b59e98a903e20e2240ae77e76dfde77
[10/11] selftests: ublk: add stress test for covering IO vs. killing ublk server
        commit: 4fcd5b5a6dff71cf82212dd208dc1765ca8a8088
[11/11] selftests: ublk: improve test usability
        commit: 22c880f446a149f5ee11260690a34d4b3f95c221

Best regards,
-- 
Jens Axboe




