Return-Path: <linux-kselftest+bounces-32968-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B339AB7777
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 23:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEFDA17DDEE
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 21:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD5A296703;
	Wed, 14 May 2025 21:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2GXJlzz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEEB22D7BF;
	Wed, 14 May 2025 21:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747256421; cv=none; b=iz2VJhdom7bTqSQzcLOEyCQVM6End52buKPGgeCmKDJQMCbWSTDZ8KbXMgmLy13oWlJwEB9tm3HVCSVXmCc2xAVlIhXZK9bMH0cRa1ItfwFMHAj4Ww4ag/Ij3mXIB2CPm1HCLwXvg1pBr6MMWOl+FWXFBWWfIzS1NzqaWbX4YDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747256421; c=relaxed/simple;
	bh=XnznhJhuk6zXlvzmK9mMxFBwsL2VmJ/Mxxl8DajyVUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MiiJRjE8BWcurpsHIDqKQ+gtN0MvIY8YSW/xb/1mei5cwW1Z+T57jyLMfP8WoT7/apw1/9YtYCPp3kuxdEXAEWSnnSbPuMFveBwXoltwOiH9iDx452Tbe8axYY1IkdNw1SSb1rqvlT+K5CIReroalprPyLjNaZThZ+3rkgnnuTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2GXJlzz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CCE9C4CEF4;
	Wed, 14 May 2025 21:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747256420;
	bh=XnznhJhuk6zXlvzmK9mMxFBwsL2VmJ/Mxxl8DajyVUU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=m2GXJlzzZ3DcMGe5d5vupazK/2jueAV1szn5X3Xil6n/XAMSotwGSaBAGAPY2auE/
	 IoZwk0Q+M3hxGtA+4RpGGdgi9Bf7BZEMacxhnrapqQVCL3jlbvLnAJtcuKld+l3w1l
	 aGtTH88W23ZGTLzQggyrcNBcogsBSJ4sHmrygbuTBi14Jv9RILus0vxa7GOfxyLvNU
	 dU8lSKB2nDExIyHxdpCVMZIxEVLqG30kUBAfxrOKf2b5EOF85oJ6QK1EZAj6DUqoGU
	 y/V35NsteEa9OWYwQMDK1WTHf+0uBClAa6fHumlR7spVIyDUCyHIm5uyMTVXNxcyB0
	 V1tuLBBZVJXCA==
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7cd0a7b672bso13526585a.2;
        Wed, 14 May 2025 14:00:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUrLLujAFuof1yLTdUSjkO6wV+3469EjYX6nqLB+KfJus7ib8aapKgse9mzKTwD2WCT+7k=@vger.kernel.org, AJvYcCX8+scPdY06EQkV85B5poxQ7pdzGfg00qTsf/ysyygzlxwYXJiDbETIEcRG71xX63BTiEPI71QLHmUBdVZ1@vger.kernel.org, AJvYcCXRp92JTnvKj+fE3new14x9fUmpjWNNOT/R0X6qDFczckiWsc5nnVcHSSAiN9W14RcuZpDQbHJXM2gGkDI=@vger.kernel.org, AJvYcCXUi8H2AZhLf0uHQBsRAvMrtdrK1MnRf2Bwc2XZJ0g8paeiUm53BEE+NZecAADCRv/Qx+LsE87Yoxk8J57hqoK+@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0ip46W8q2J+JoMltY3oWoX+DOoGvGWgyqoxFyUW/umXKX/HIS
	jzmvVO3dZ90X78tQ+euDWX3ICWWJWwGx7zutbrTYY5Vi5ZIyCzqO128Fo6BdpQPNP2HzUJgXl0/
	9aVtSJDiqc/F4GEBn6i+TgZUo4O8=
X-Google-Smtp-Source: AGHT+IEhk7L+lq3nvFFbRnQz3zzW13v/TUfQdGY8T5liXifuEFN1njdktgiHu8lQDra2Hjw2x4vIHEc90h2a4f2wyjU=
X-Received: by 2002:a05:6214:29ea:b0:6f5:46b0:7d11 with SMTP id
 6a1803df08f44-6f896eacaa6mr95493576d6.36.1747256418120; Wed, 14 May 2025
 14:00:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250513163601.812317-1-tjmercier@google.com> <20250513163601.812317-6-tjmercier@google.com>
In-Reply-To: <20250513163601.812317-6-tjmercier@google.com>
From: Song Liu <song@kernel.org>
Date: Wed, 14 May 2025 14:00:06 -0700
X-Gmail-Original-Message-ID: <CAPhsuW50mA3hhirHBiZ2miBeC0uAN=KxyYKBJ_hHgmFx-cvaNw@mail.gmail.com>
X-Gm-Features: AX0GCFuntU3ESTAS15kAsHIf6pG-Tbi7KiDkSGJvlMEE3mBjavdb8gFnDOzUmFQ
Message-ID: <CAPhsuW50mA3hhirHBiZ2miBeC0uAN=KxyYKBJ_hHgmFx-cvaNw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 5/5] selftests/bpf: Add test for open coded dmabuf_iter
To: "T.J. Mercier" <tjmercier@google.com>
Cc: sumit.semwal@linaro.org, christian.koenig@amd.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	skhan@linuxfoundation.org, alexei.starovoitov@gmail.com, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, android-mm@google.com, 
	simona@ffwll.ch, eddyz87@gmail.com, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 9:36=E2=80=AFAM T.J. Mercier <tjmercier@google.com>=
 wrote:
>
> Use the same test buffers as the traditional iterator and a new BPF map
> to verify the test buffers can be found with the open coded dmabuf
> iterator.
>
> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Acked-by: Song Liu <song@kernel.org>
> ---
>  .../testing/selftests/bpf/bpf_experimental.h  |  5 +++
>  .../selftests/bpf/prog_tests/dmabuf_iter.c    | 41 +++++++++++++++++++
>  .../testing/selftests/bpf/progs/dmabuf_iter.c | 38 +++++++++++++++++
>  3 files changed, 84 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testi=
ng/selftests/bpf/bpf_experimental.h
> index 6535c8ae3c46..5e512a1d09d1 100644
> --- a/tools/testing/selftests/bpf/bpf_experimental.h
> +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> @@ -591,4 +591,9 @@ extern int bpf_iter_kmem_cache_new(struct bpf_iter_km=
em_cache *it) __weak __ksym
>  extern struct kmem_cache *bpf_iter_kmem_cache_next(struct bpf_iter_kmem_=
cache *it) __weak __ksym;
>  extern void bpf_iter_kmem_cache_destroy(struct bpf_iter_kmem_cache *it) =
__weak __ksym;
>
> +struct bpf_iter_dmabuf;
> +extern int bpf_iter_dmabuf_new(struct bpf_iter_dmabuf *it) __weak __ksym=
;
> +extern struct dma_buf *bpf_iter_dmabuf_next(struct bpf_iter_dmabuf *it) =
__weak __ksym;
> +extern void bpf_iter_dmabuf_destroy(struct bpf_iter_dmabuf *it) __weak _=
_ksym;
> +
>  #endif
> diff --git a/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c b/tools=
/testing/selftests/bpf/prog_tests/dmabuf_iter.c
> index dc740bd0e2bd..6c2b0c3dbcd8 100644
> --- a/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c
> +++ b/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c
> @@ -219,14 +219,52 @@ static void subtest_dmabuf_iter_check_default_iter(=
struct dmabuf_iter *skel)
>         close(iter_fd);
>  }
>
> +static void subtest_dmabuf_iter_check_open_coded(struct dmabuf_iter *ske=
l, int map_fd)
> +{
> +       LIBBPF_OPTS(bpf_test_run_opts, topts);
> +       char key[DMA_BUF_NAME_LEN];
> +       int err, fd;
> +       bool found;
> +
> +       /* No need to attach it, just run it directly */
> +       fd =3D bpf_program__fd(skel->progs.iter_dmabuf_for_each);
> +
> +       err =3D bpf_prog_test_run_opts(fd, &topts);
> +       if (!ASSERT_OK(err, "test_run_opts err"))
> +               return;
> +       if (!ASSERT_OK(topts.retval, "test_run_opts retval"))
> +               return;
> +
> +       if (!ASSERT_OK(bpf_map_get_next_key(map_fd, NULL, key), "get next=
 key"))
> +               return;
> +
> +       do {
> +               ASSERT_OK(bpf_map_lookup_elem(map_fd, key, &found), "look=
up");
> +               ASSERT_TRUE(found, "found test buffer");

This check failed once in the CI, on s390:

Error: #89/3 dmabuf_iter/open_coded
9309 subtest_dmabuf_iter_check_open_coded:PASS:test_run_opts err 0 nsec
9310 subtest_dmabuf_iter_check_open_coded:PASS:test_run_opts retval 0 nsec
9311 subtest_dmabuf_iter_check_open_coded:PASS:get next key 0 nsec
9312 subtest_dmabuf_iter_check_open_coded:PASS:lookup 0 nsec
9313 subtest_dmabuf_iter_check_open_coded:FAIL:found test buffer
unexpected found test buffer: got FALSE

But it passed in the rerun. It is probably a bit flakey. Maybe we need some
barrier somewhere.

Here is the failure:

https://github.com/kernel-patches/bpf/actions/runs/15002058808/job/42234864=
754

To see the log, you need to log in GitHub.

Thanks,
Song

> +       } while (bpf_map_get_next_key(map_fd, key, key));
> +}

[...]

