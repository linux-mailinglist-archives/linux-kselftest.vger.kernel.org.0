Return-Path: <linux-kselftest+bounces-16027-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C952895B167
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 11:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5A8F1C20AC6
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 09:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1802D18308A;
	Thu, 22 Aug 2024 09:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VtAmLXtz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A17413DDBA;
	Thu, 22 Aug 2024 09:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724318431; cv=none; b=hoym1kah9MBh7s9ppZdmjTI0M5+eP/jz3y05N5/kYdCZuIiW3nMDKIaZpNwulf1hbHbdcYFPoCpH6ha/9e53ew0ws/JqbynD4sKqhLiU/Dbcbg4iB0eL/HUVJ6WvEpV9X/bVv3UedV0TUIxLLQ5U26a2EvE+0+lLob4KdeBP/8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724318431; c=relaxed/simple;
	bh=wa11E4vC16meyt/HRGlxBpjY6+NDyQ8gzq+Zo4740EM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJ0UW93q6q1d6MOd5wquhqPGALSlm0pICbNFFZ/qq8bUVoy5AvxpbBLbDtlpWNEbLD8axi9UW8g83uMNDFkomJNMiIp35KxAqKTAfP4AveIGmSaGRK+/Pz1y0GH8ESgz598GSTQA/tZoB04wQOd6Y2n+B+6u5wIXOFIcLAp7CKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VtAmLXtz; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2d3c071d276so400828a91.1;
        Thu, 22 Aug 2024 02:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724318429; x=1724923229; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MyKLfBPeA5XoHzpM60pqMjyl1ufI4H7IKPsGxUcKYe0=;
        b=VtAmLXtzFHOUO4nJShXKtkyP9nYDlyNEX0uuMdbpgtrCPtlCBHoy4cEFE2aECldVAa
         czMUQQWiugks7yDu8/MJ8Ne1WvageMRJGLUVZyHzqdr9mhWgjlsPEw0s+WVoVo7TQWNs
         4ZObI38B8pMPCYBnxaMQDNJ4DVghafq0MMUwI87YHKwboYWn2roDpfnyjVKWZohC/Rve
         cLr3Q4kxu8DmTeK0FiVj3+cE35aUEGZP8humoPb59+vVKPF2YisDMfnddm6M897IWx1c
         3Iz8B83PAP7gR7XrpGmnc6DfC8cEOyQWygSuWrYOwWXtw+r5FlqEfknSR4vbsEyrHn6s
         rAkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724318429; x=1724923229;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MyKLfBPeA5XoHzpM60pqMjyl1ufI4H7IKPsGxUcKYe0=;
        b=Z2Z6IQkG5qcwncEaLB2zHlHhS6AamQVKOEU4I6ZTe9pQirbBL8ft447rbvwiC6WOiU
         mx2f5B66Q15ZVcsIa5yVfNorWL0Fl5eHprBzB/IiISyBqwIY4dO3sjL3qXNLAd3y/tLW
         jqaqWuc5HDwVbsTOGlDtae7xZjn0ttbySHGXUxZe5n3q3Pew23xQl6PLeblKiew93d6J
         nEZieBRUjCgLQSdBBc/W5oNOKf2jSIKbXw8QjnF3Yi96LUX+Wqw3oZ89mDgiS7DBnXJO
         ukTUIeYkd9enMeFdGjQy3SCjLU62ea293+QwaEni1NfWeJ/5kMwLjgMRG6SoQSIKWfhG
         U4QA==
X-Forwarded-Encrypted: i=1; AJvYcCWfsj2AD1B4X0/E9NBgHSD0O1yVkLfk7wpJ1tIAO0eQmuK+X9TvguloHe34Tt5Ve/x2bxeL5ksCrz9+PGN7Qd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzprH2aTZ/25+Kq6sKW4nkjc3WuAVpONkX1fKOxaBVmCqUtgIx
	V8s9u7uqdd0n+3Pbshoy/WmZCsprAXtaoCW2eiMbnBMijeOin0Rh
X-Google-Smtp-Source: AGHT+IGr3A873mZtkqvDzilnFaS1by2i3RHoxnCkO8ZUQ7LDkHORbnZcmyrgl2NFlt5WFhFXkYu8iQ==
X-Received: by 2002:a17:90a:17e7:b0:2d3:bd5f:b369 with SMTP id 98e67ed59e1d1-2d6169beceemr1466584a91.1.1724318428751;
        Thu, 22 Aug 2024 02:20:28 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d61392a1efsm1239298a91.21.2024.08.22.02.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 02:20:28 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Thu, 22 Aug 2024 02:20:26 -0700
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH bpf-next v1 5/8] libbpf: Support opening bpf objects of
 either endianness
Message-ID: <ZscC2gam99zILmz6@kodidev-ubuntu>
References: <cover.1724216108.git.tony.ambardar@gmail.com>
 <62a2ef41629ad5ef7db48d720959527462e1beca.1724216108.git.tony.ambardar@gmail.com>
 <CAADnVQJ2XW0QwSGAaqzEUY4jozF6ML3dxr0mE7hGct0-6hKNnA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJ2XW0QwSGAaqzEUY4jozF6ML3dxr0mE7hGct0-6hKNnA@mail.gmail.com>

On Wed, Aug 21, 2024 at 06:55:58PM -0700, Alexei Starovoitov wrote:
> On Wed, Aug 21, 2024 at 2:10 AM Tony Ambardar <tony.ambardar@gmail.com> wrote:
> >
> >
> > +static inline void bpf_insn_bswap(struct bpf_insn *insn)
> > +{
> > +       /* dst_reg & src_reg nibbles */
> > +       __u8 *regs = (__u8 *)insn + offsetofend(struct bpf_insn, code);
> > +
> > +       *regs = (*regs >> 4) | (*regs << 4);
> > +       insn->off = bswap_16(insn->off);
> > +       insn->imm = bswap_32(insn->imm);
> > +}
> 
> This is really great!
> Thank you for working on it.

Happy to help! The endian restrictions were a long-time annoyance for me.

> 
> This idea was brought up a couple times, since folks want to compile
> bpf prog once, embed it into their user space binary,
> and auto adjust to target endianness.
> Cross compilation isn't important to them,
> but the ability to embed a single .o instead of two .o-s is a big win.

Ah, interesting use case. I hadn't really considered that or tested it.
I suppose .symtab and .rel* have ELF types so OK, .strtab doesn't matter,
and now we have BTF/BTF.ext converters, so why not? Something like light
skeleton might be a problem though, because the data blob is
heterogeneous and would be hard to convert byte-order after writing.

> 
> It's great that the above insn, elf and btf adjustments are working.
> Since endianness is encoded in elf what's the point of
> extra btf_ext__endianness libbpf api?
> Aren't elf and btf.ext suppose to be in the same endianness all the time?

I implemented BTF.ext following the BTF endianness API example, which
handles raw BTF, in-memory, and not just ELF object files. With BTF,
we have API clients like pahole, but only internal usage so far for
BTF.ext, and no notion of "raw" BTF.ext. I suppose exposing an API
for btf_ext__endianness isn't strictly needed right now, but I can
imagine BTF-processing clients using it. What are your thoughts, Andrii?

BTW, I just fixed a bug in my light skeleton code that made test_progs
'map_ptr' fail, so will be sending out a v2 patch.

Currently, I have only 2 unexpected test failures on s390x:

subtest_userns:PASS:socketpair 0 nsec
subtest_userns:PASS:fork 0 nsec
recvfd:PASS:recvmsg 0 nsec
recvfd:PASS:cmsg_null 0 nsec
recvfd:PASS:cmsg_len 0 nsec
recvfd:PASS:cmsg_level 0 nsec
recvfd:PASS:cmsg_type 0 nsec
parent:PASS:recv_bpffs_fd 0 nsec
materialize_bpffs_fd:PASS:fs_cfg_cmds 0 nsec
materialize_bpffs_fd:PASS:fs_cfg_maps 0 nsec
materialize_bpffs_fd:PASS:fs_cfg_progs 0 nsec
materialize_bpffs_fd:PASS:fs_cfg_attachs 0 nsec
parent:PASS:materialize_bpffs_fd 0 nsec
sendfd:PASS:sendmsg 0 nsec
parent:PASS:send_mnt_fd 0 nsec
recvfd:PASS:recvmsg 0 nsec
recvfd:PASS:cmsg_null 0 nsec
recvfd:PASS:cmsg_len 0 nsec
recvfd:PASS:cmsg_level 0 nsec
recvfd:PASS:cmsg_type 0 nsec
parent:PASS:recv_token_fd 0 nsec
parent:FAIL:waitpid_child unexpected error: 22 (errno 3)
#402/9   token/obj_priv_implicit_token_envvar:FAIL

and

libbpf: prog 'on_event': BPF program load failed: Bad address
libbpf: prog 'on_event': -- BEGIN PROG LOAD LOG --
The sequence of 8193 jumps is too complex.
verification time 2633000 usec
stack depth 360
processed 116096 insns (limit 1000000) max_states_per_insn 1 total_states 5061 peak_states 5061 mark_read 2540
-- END PROG LOAD LOG --
libbpf: prog 'on_event': failed to load: -14
libbpf: failed to load object 'pyperf600.bpf.o'
scale_test:FAIL:expect_success unexpected error: -14 (errno 14)
#525     verif_scale_pyperf600:FAIL


I'd appreciate any thoughts on troubleshooting these, and will continue
looking into them.

Cheers,
Tony

