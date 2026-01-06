Return-Path: <linux-kselftest+bounces-48337-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79066CFA501
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 19:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 326873252929
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 18:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AEC3502BC;
	Tue,  6 Jan 2026 17:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="njyfa1Rx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC523502AC;
	Tue,  6 Jan 2026 17:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767721473; cv=none; b=ooNxFDikOeJLk7U1OcVdda/f8folrDAAOEzyeby2h02aCmt2fu0ZapVEMS9LnqJQpDsZLugqlPNIrJg7ORhEtDGBuoZeqoaVA8gErU8wcC+BYaqWFfBLxujUkiPyn6ktQ9zqbKbcjX7UB0Z74Jhqf6JjQHFQdTbIsKIHQdazVOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767721473; c=relaxed/simple;
	bh=OryeiQL9V1ShuYrv8grMsRnle5IZx/eVvb7YtNXlOiU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=b9NoOYwb2g3XkFMrL4BzUP7QEbJc0wflK3pEgiqUyWs/cqQfZPKMphbEF0n6nJJSgr8witn7WJhF+7sGAB41M6TSekII6p3Y9OIQWXVYxVROsXEceOfLNZ++c8T3AUXxUlrjTva5GysMIR9sbEkAHGDT82uhrYxjBzxzlsklOV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=njyfa1Rx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C25C116C6;
	Tue,  6 Jan 2026 17:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767721472;
	bh=OryeiQL9V1ShuYrv8grMsRnle5IZx/eVvb7YtNXlOiU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=njyfa1RxGQPyGMeq7siQSLlMa1mRtYKzY5sKPzuMhFbI/OVIBeo5nvHEhFjYJUmbj
	 i7BnnE9du8VPC67CVgajROsX7R9N2cO56Szlfg60IY6qTWpaQp09+3Lu3r9wfHPTsJ
	 nc/USqC6R87y3E/H3BCn6SQRAgI0Slt4y+PbvcoydsdsGcsvTboQyMJs0VZ/H33FY0
	 ZK4TyJtUe6v7mMkrHuxkmZ68gN2bn+EthJqRe7WXdu+nRIHUn/NNM8wSWyJFfbH61A
	 pzCqrdfx5GdRz1YbYEa30kd/SEHN26wu94I54OS75aPl6p7uE5UaeQNQ6jCHimBXdK
	 mGLsFpRwIgYRA==
Content-Type: multipart/mixed; boundary="===============3784221737981949726=="
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <db428e27fdf0110ea05cdadf8980c7758d7f4dcd61289293394db7e34ce99601@mail.kernel.org>
In-Reply-To: <20260106172018.57757-8-leon.hwang@linux.dev>
References: <20260106172018.57757-8-leon.hwang@linux.dev>
Subject: Re: [RESEND PATCH bpf-next v4 7/9] bpf: Add common attr support for map_create
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,brauner@kernel.org,oleg@redhat.com,leon.hwang@linux.dev,sforshee@kernel.org,yuichtsu@amazon.com,aalbersh@redhat.com,willemb@google.com,kerneljasonxing@gmail.com,paul.chaignon@gmail.com,yatsenko@meta.com,memxor@gmail.com,a.s.protopopov@gmail.com,ameryhung@gmail.com,rongtao@cestc.cn,linux-kernel@vger.kernel.org,linux-api@vger.kernel.org,linux-kselftest@vger.kernel.org,kernel-patches-bot@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  6 Jan 2026 17:44:31 +0000 (UTC)

--===============3784221737981949726==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 14fc5738f2b9..e64cc7504731 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c

[ ... ]

> @@ -6279,7 +6345,11 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
>
>  	switch (cmd) {
>  	case BPF_MAP_CREATE:
> -		err = map_create(&attr, uattr);
> +		common_attrs.log_true_size = 0;
> +		err = map_create(&attr, uattr, &common_attrs);
> +		ret = copy_common_attr_log_true_size(uattr_common, size_common,
> +						     &common_attrs.log_true_size);
> +		err = ret ? ret : err;

When map_create() succeeds, it returns a file descriptor that is already
installed in the caller's fd table via bpf_map_new_fd(). If
copy_common_attr_log_true_size() then fails (e.g., user provided a
read-only buffer for uattr_common), the syscall returns -EFAULT but the
fd remains installed.

Could this leak the file descriptor? The user gets an error and has no
way to know what fd number was allocated, so they cannot close it.

The sequence would be:
  1. map_create() succeeds, returns fd (e.g., 5)
  2. copy_common_attr_log_true_size() fails, ret = -EFAULT
  3. err = ret ? ret : err = -EFAULT
  4. syscall returns -EFAULT
  5. map and fd persist, but user cannot close fd 5

> +		break;
>  	case BPF_MAP_LOOKUP_ELEM:
>  		err = map_lookup_elem(&attr);


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20756616585

--===============3784221737981949726==--

