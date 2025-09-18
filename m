Return-Path: <linux-kselftest+bounces-41795-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84043B8270B
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 02:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3600D1C275D3
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 00:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57488224249;
	Thu, 18 Sep 2025 00:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzGvJlF3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8475C1EE7B9
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Sep 2025 00:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758156380; cv=none; b=DVqfMDm9EFpNlvvQHiEGen/7TNHrybK/aHG6Otp+t7/9QgFj/hP3jhsympaGGa8JQMhwmlCXKsy6/DYtKGwuO27tx0yG+hj3XNYG7ryLxus697FyMcFy6+m3R9PqArSW1QUh97+RSkmkK3jtC+EBADPkurZGuvqlTfV3ZsFdoOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758156380; c=relaxed/simple;
	bh=UIo7RA/G/xDD02JBTiyBlQlJJd9IfyisvvvnbSKMNJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uqy7D4lFah4N3PkB44xFXJM8DbIBoYvh1VTBh4PCqKij2ojk6kPN1Nz4YhIaP1zxi7ZYypxvAb0DH3gm/39F15PLhbWdkcAOhKYlwbYmM1jW4IcG6eFkbNFgeSEBgEOa2XlIuMA2ow+joV1VskZLY3eY69bMprm6E7mkQnoz/8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KzGvJlF3; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b04ba3de760so50086266b.0
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Sep 2025 17:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758156375; x=1758761175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ScdSoNWwYp7Lx1FqF0sJinLc5HuMMzMbeEOteqLeKGY=;
        b=KzGvJlF3KPV470aj9p2+WGc+dHQyYumQ/n1JBBocmuZJA49YLeiUqmwy+/yYPZgQZj
         ssXCb7z6YgYiOutrT3AfsrRikN0B83+7ruvziWNhCwsz2ELTIiizmfls7PvsFdkvcJLT
         qpJdXp6xZhBTLS5nekg+F1LDSdhm19EysHMtk07fabj1P6oLuOyCMfvOGen6jT1eBwbP
         6pMnjF6KJT+0XEj91pCTwQujjt7F6ghOtnCnJ+EU2+tXugoJTsFgk+QsjwfhKOKRRjgu
         d9FePQZs61kpvgUTD0qeflLnFiVK5p7eAvAv3yf1sOrJiE6TsrG+zJ2UIlYBCl4PmRtc
         hKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758156375; x=1758761175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ScdSoNWwYp7Lx1FqF0sJinLc5HuMMzMbeEOteqLeKGY=;
        b=xAeM1/f20RnNkbfeoAe8zSHs6qVksotiE43CoZ0CUynhjSwP4jKmKfbBKGsKae6cYR
         cQDCoY7ksIHR9M3sgIzvsHylBgJbVnCiukN0tL4saxiRj6uZ6zHscCuoRD94DeH3+h01
         lKPSfQ/sLhY36C3LAXpeI92y5n4ohXsJuRks/awoC2o8CHswTtLMUte3ekmv4Z0Q6Pz6
         PIELXpKEw0syeY3w4ilQfMniT+y1FqHHDf8HKdb9Y7WtVU6UB3aeoYesxz3XPpU9ZoaZ
         5Q6FTEZHsI9OABOtXg/1HjXFEETWQbFkcMWSVOKWZYJub0DoOpkcb0n3yr6rGnzXyAuL
         dQJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhdY4o2BRaHHFO1AdVal8csBsbqcdIgXl8FR9J/oLka/hzBBKHARpkHVyDgG07XV+rmOmw8tLCgnPqBihFwfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaLKFBRjW1CExq3gmrKBQFWhWeelp4La0S93fbnV8+URwr+Nf7
	xC7oKpDo7LAfgcHHZlLJNGuQSR/AYQgFP6RR+7NUx1ypKtIWvjfULdTF
X-Gm-Gg: ASbGncvaschlNLYu0P2Q5IJdtkHmm/JA4jDI//21SyHgYFNifheq4aZUa/rtxH6OO7+
	mzcJevHRj1aU/YZYWpR6ICJYEsISaZpo5u9B/+CiX4/Gvom0AMOHF1RZGSmIIK177bk2Zzaq+uw
	YA2LAfvNXxvmCAbAi7jYiR26ZPvmSjo5pMdrRzNmQvu9L5+9Fq5NyYSKJgiV+ChjktzZipxux6C
	iJNEqKE37UV6LmJqeQs19ldlQDUXtBSc2TtbHZeCvxYlSYZgqW6n0NNfZYnqj4jVPGsNxKFxRFf
	dB3usHbNiSqdj83sf6qPiqvoBiGWAIiYvt5kaEstorFTPYmoBTes6NgdXEuB/7w/hv7T7feJhiJ
	G1KZMRIo6xgZKCEWltE7jLzUtD+T6gkehO+SX8w==
X-Google-Smtp-Source: AGHT+IGtolM3WpmMOfPkC5aQN2+QGXojyD9zctBgGDhejOP10KXv+fVObxP+zNTcUHL0l2vGVmYa+w==
X-Received: by 2002:a17:907:7291:b0:b07:c28f:19c8 with SMTP id a640c23a62f3a-b1bb7d419c3mr514517266b.30.1758156374473;
        Wed, 17 Sep 2025 17:46:14 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b1fd271ead3sm73266366b.101.2025.09.17.17.46.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 17:46:14 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: brauner@kernel.org
Cc: amir73il@gmail.com,
	axboe@kernel.dk,
	cgroups@vger.kernel.org,
	chuck.lever@oracle.com,
	cyphar@cyphar.com,
	daan.j.demeyer@gmail.com,
	edumazet@google.com,
	hannes@cmpxchg.org,
	horms@kernel.org,
	jack@suse.cz,
	jlayton@kernel.org,
	josef@toxicpanda.com,
	kuba@kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	me@yhndnzj.com,
	mkoutny@suse.com,
	mzxreary@0pointer.de,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	tj@kernel.org,
	viro@zeniv.linux.org.uk,
	zbyszek@in.waw.pl
Subject: Re: [PATCH 17/32] mnt: support iterator
Date: Thu, 18 Sep 2025 03:46:06 +0300
Message-ID: <20250918004606.1081264-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250910-work-namespace-v1-17-4dd56e7359d8@kernel.org>
References: <20250910-work-namespace-v1-17-4dd56e7359d8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Move the mount namespace to the generic iterator.
> This allows us to drop a bunch of members from struct mnt_namespace.
>                                                                       t
> Signed-off-by: Christian Brauner <brauner@kernel.org>

There is weird "t" here floating at the right

-- 
Askar Safin

