Return-Path: <linux-kselftest+bounces-32825-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E29AB2617
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 May 2025 04:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A6771746EF
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 May 2025 02:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DA6D27E;
	Sun, 11 May 2025 02:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDnSzTay"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6F7BA45
	for <linux-kselftest@vger.kernel.org>; Sun, 11 May 2025 02:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746928898; cv=none; b=PRvkGk3lKowX+6MID1xPTR56/BF3vcXM6+W2jSKxpuhLuw61P/nPdc3eb5zl1b5a/cP4NTsA4EuVK+oCEox1H3Yw+SK/ilE/W10qBI8GH2WX5CLQHwZgJDEUxW00J7bHQxzbQibksN2mzPTMQebWr+xHbF4/hxXX4dSTFPbNuU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746928898; c=relaxed/simple;
	bh=Uud/c+M6EfwYviLXv3JhG9QXpJjkB+v/1YKSMnhuxYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=meyCxWZOl2wsKznuaGAbyNRomuLeR8Jp3FpDNWrf3eh/vKkKBL/g+wWjL+9yUSdRfkrWQhxyPTK4R9qmbvdXuYO3fS50hBAevRMA8XEjhq/FfTd9KgjCt5X8qt1dqUl+VZ4jAi2EdRpEu1Erya14C4ejlN786rPe/51x6sq7lQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDnSzTay; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D917AC4CEE2
	for <linux-kselftest@vger.kernel.org>; Sun, 11 May 2025 02:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746928897;
	bh=Uud/c+M6EfwYviLXv3JhG9QXpJjkB+v/1YKSMnhuxYs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YDnSzTay6Ijejbz36uQbQq7tRUTkrcurmR2AlPS3GG+mo3H5hSGYwtox13q954BWX
	 mtVetJCfsvl0qC4Ibd+SPR4jsQi9ELL07j9gEKOPVGoPljY0cXlgAfCN4v67QAJSJe
	 khRZEEgRFyxdxQCa6+3gqArCtwX09eZuA/2rzBpZ+CmkokRqgDEAqoqe4hUvQFuGch
	 xAU2+aCgFN09F7segiQwlgcwl6m0yW5t1IisJ8UwBl4nr03bRtbE5x9km3fl65wHZF
	 r0eet+WgnPQcaq7y7qt03IsIqn5sGLC59iRntAD/iQ9sYFZpQteLuqLAUFgtkMKbPr
	 9hjNvR1QogrlQ==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5fd1f7f8b25so598307a12.0
        for <linux-kselftest@vger.kernel.org>; Sat, 10 May 2025 19:01:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUOJ2+0OnGp+v374mUk/CBT5S1DbJWwPF6yqOf9qtuy58cL83Votr6xGaqVB+8KEdav5fpCrr/3C99PGFgwNIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFHXYsGAhlWfzx8qtb+MO577xdFXd8ngMC5/YdGr5ThECKtHOQ
	vS/3/s5dANdqjx9TnJX64wnK8qznmRpCKnFLE9+DQ5N+LOeRBQQ6Dy6adTupnQwdok/h5RqcvYS
	B7RIrBMdLVN0rvz4JrIWN0eaJolIGG/MWwrRi
X-Google-Smtp-Source: AGHT+IEndbWplSJxFGd74VrtGrhFU2hW9QCIiBQIkWd6Wv+M3EzLZDUhAbkzCtB+Hip0tzqQSM6gufYVYT1/8EGDpuY=
X-Received: by 2002:a05:6402:2688:b0:5fd:1972:99da with SMTP id
 4fb4d7f45d1cf-5fd19729aa8mr1758195a12.23.1746928896391; Sat, 10 May 2025
 19:01:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502184421.1424368-1-bboscaccy@linux.microsoft.com>
 <20250502210034.284051-1-kpsingh@kernel.org> <CAHC9VhS5Vevcq90OxTmAp2=XtR1qOiDDe5sSXReX5oXzf+siVQ@mail.gmail.com>
 <CACYkzJ5jsWFiXMRDwoGib5t+Xje6STTuJGRZM9Vg2dFz7uPa-g@mail.gmail.com>
In-Reply-To: <CACYkzJ5jsWFiXMRDwoGib5t+Xje6STTuJGRZM9Vg2dFz7uPa-g@mail.gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Sun, 11 May 2025 04:01:25 +0200
X-Gmail-Original-Message-ID: <CACYkzJ6VQUExfyt0=-FmXz46GHJh3d=FXh5j4KfexcEFbHV-vg@mail.gmail.com>
X-Gm-Features: AX0GCFvon_jvokApR2EuF7DFGQb8hyY-4kxy54yUF6qWCWTtHAsfnnk2ydLvo-Y
Message-ID: <CACYkzJ6VQUExfyt0=-FmXz46GHJh3d=FXh5j4KfexcEFbHV-vg@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Introducing Hornet LSM
To: Paul Moore <paul@paul-moore.com>
Cc: bboscaccy@linux.microsoft.com, James.Bottomley@hansenpartnership.com, 
	bpf@vger.kernel.org, code@tyhicks.com, corbet@lwn.net, davem@davemloft.net, 
	dhowells@redhat.com, gnoack@google.com, herbert@gondor.apana.org.au, 
	jarkko@kernel.org, jmorris@namei.org, jstancek@redhat.com, 
	justinstitt@google.com, keyrings@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-security-module@vger.kernel.org, 
	llvm@lists.linux.dev, masahiroy@kernel.org, mic@digikod.net, morbo@google.com, 
	nathan@kernel.org, neal@gompa.dev, nick.desaulniers+lkml@gmail.com, 
	nicolas@fjasle.eu, nkapron@google.com, roberto.sassu@huawei.com, 
	serge@hallyn.com, shuah@kernel.org, teknoraver@meta.com, 
	xiyou.wangcong@gmail.com, kysrinivasan@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > I think we need a more detailed explanation of this approach on-list.
> > There has been a lot of vague guidance on BPF signature validation
> > from the BPF community which I believe has partly led us into the
> > situation we are in now.  If you are going to require yet another
> > approach, I think we all need to see a few paragraphs on-list
> > outlining the basic design.
>
> Definitely, happy to share design / code.

Here=E2=80=99s the design that Alexei and I have been discussing. It's
extensible, independent of ELF formats, handles all identified
use-cases, paves the way for signed unprivileged eBPF, and meets the
requirements of anyone who wants to run signed eBPF programs.

# Trusted Hash Chain

The key idea of the design is to use a signing algorithm that allows
us to integrity-protect a number of future payloads, including their
order, by creating a chain of trust.

Consider that Alice needs to send messages M_1, M_2, ..., M_n to Bob.
We define blocks of data such that:

    B_n =3D M_n || H(termination_marker)

(Each block contains its corresponding message and the hash of the
*next* block in the chain.)

    B_{n-1} =3D M_{n-1} || H(B_n)
    B_{n-2} =3D M_{n-2} || H(B_{n-1})

  ...

    B_2 =3D M_2 || H(B_3)
    B_1 =3D M_1 || H(B_2)

Alice does the following (e.g., on a build system where all payloads
are available):

  * Assembles the blocks B_1, B_2, ..., B_n.
  * Calculates H(B_1) and signs it, yielding Sig(H(B_1)).

Alice sends the following to Bob:

    M_1, H(B_2), Sig(H(B_1))

Bob receives this payload and does the following:

    * Reconstructs B_1 as B_1' using the received M_1 and H(B_2)
(i.e., B_1' =3D M_1 || H(B_2)).
    * Recomputes H(B_1') and verifies the signature against the
received Sig(H(B_1)).
    * If the signature verifies, it establishes the integrity of M_1
and H(B_2) (and transitively, the integrity of the entire chain). Bob
now stores the verified H(B_2) until it receives the next message.
    * When Bob receives M_2 (and H(B_3) if n > 2), it reconstructs
B_2' (e.g., B_2' =3D M_2 || H(B_3), or if n=3D2, B_2' =3D M_2 ||
H(termination_marker)). Bob then computes H(B_2') and compares it
against the stored H(B_2) that was verified in the previous step.

This process continues until the last block is received and verified.

Now, applying this to the BPF signing use-case, we simplify to two messages=
:

    M_1 =3D I_loader (the instructions of the loader program)
    M_2 =3D M_metadata (the metadata for the loader program, passed in a
map, which includes the programs to be loaded and other context)

For this specific BPF case, we will directly sign a composite of the
first message and the hash of the second. Let H_meta =3D H(M_metadata).
The block to be signed is effectively:

    B_signed =3D I_loader || H_meta

The signature generated is Sig(B_signed).

The process then follows a similar pattern to the Alice and Bob model,
where the kernel (Bob) verifies I_loader and H_meta using the
signature. Then, the trusted I_loader is responsible for verifying
M_metadata against the trusted H_meta.

From an implementation standpoint:

# Build

bpftool (or some other tool in the user's build environment) knows
about the metadata (M_metadata) and the loader program (I_loader). It
first calculates H_meta =3D H(M_metadata). Then it constructs the object
to be signed and computes the signature:

    Sig(I_loader || H_meta)

# Loader

bpftool generates the loader program. The initial instructions of this
loader program are designed to verify the SHA256 hash of the metadata
(M_metadata) that will be passed in a map. These instructions
effectively embed the precomputed H_meta as immediate values.

    ld_imm64 r1, const_ptr_to_map // insn[0].src_reg =3D=3D BPF_PSEUDO_MAP_=
IDX
    r2 =3D *(u64 *)(r1 + 0);
    ld_imm64 r3, sha256_of_map_part1 // constant precomputed by
bpftool (part of H_meta)
    if r2 !=3D r3 goto out;

    r2 =3D *(u64 *)(r1 + 8);
    ld_imm64 r3, sha256_of_map_part2 // (part of H_meta)
    if r2 !=3D r3 goto out;

    r2 =3D *(u64 *)(r1 + 16);
    ld_imm64 r3, sha256_of_map_part3 // (part of H_meta)
    if r2 !=3D r3 goto out;

    r2 =3D *(u64 *)(r1 + 24);
    ld_imm64 r3, sha256_of_map_part4 // (part of H_meta)
    if r2 !=3D r3 goto out;
    ...

This implicitly makes the payload equivalent to the signed block (B_signed)

    I_loader || H_meta

bpftool then generates the signature of this I_loader payload (which
now contains the expected H_meta) using a key (system or user) with
new flags that work in combination with bpftool -L

This signature is stored in bpf_attr, which is extended as follows for
the BPF_PROG_LOAD command:

    __aligned_u64 signature;
    __u32 signature_size;
    __u32 user_keyring_serial;
    __u64 system_keyring_id;

# New BPF Commands

## BPF_MAP_GET_HASH args: (map_fd, &sha256_output, output_size)

This command instructs the kernel to compute the SHA256 hash of the
map's data. If sha256_output is non-NULL, the hash is returned to
userspace. (While not strictly needed for this specific signing
use-case to function, it's a useful utility for userspace debugging or
other applications.)

The kernel also stores this computed hash internally within its struct bpf_=
map:

    struct bpf_map {
    +   u64 sha[4];
        const struct bpf_map_ops *ops;
        struct bpf_map *inner_map_meta;
    };

## BPF_MAP_MAKE_EXCLUSIVE args: (map_fd, sha256_of_future_prog)

Exclusivity ensures that the map can only be used by a future BPF
program whose SHA256 hash matches sha256_of_future_prog.

First, bpf_prog_calc_tag() is updated to compute the SHA256 instead of
SHA1, and this hash is stored in struct bpf_prog_aux:

    @@ -1588,6 +1588,7 @@ struct bpf_prog_aux {
         int cgroup_atype; /* enum cgroup_bpf_attach_type */
         struct bpf_map *cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE];
         char name[BPF_OBJ_NAME_LEN];
    +    u64 sha[4];
         u64 (*bpf_exception_cb)(u64 cookie, u64 sp, u64 bp, u64, u64);
         // ...
    };

Once BPF_MAP_MAKE_EXCLUSIVE is called with map_fd and the target
program's SHA256 hash, the kernel marks the map as exclusive. When a
BPF program is subsequently loaded, if it attempts to use this map,
the kernel will compare the program's own SHA256 hash against the one
registered with the map, if matching, it will be added to
prog->used_maps[]. The program load will fail if the hashes do not
match or if the map is already in use by another (non-matching)
exclusive program.

Any program with a different SHA256 will fail to load if it attempts
to use the exclusive map.

NOTE: Exclusive maps cannot be added as inner maps.

# Light Skeleton Sequence (Userspace Example)

    // Create and populate the metadata map

    map_fd =3D skel_map_create(BPF_MAP_TYPE_ARRAY, "__loader.map", 4,
opts->data_sz, 1);
    skel_map_update_elem(map_fd, &key, opts->data, 0);

    // Freeze the map to prevent further userspace modifications.
    // This makes its content immutable from userspace.

    skel_map_freeze(map_fd);

    // Make the map exclusive to the intended loader program.
    // sha256_of_loader_prog is the hash of the I_loader binary
    skel_map_make_exclusive(map_fd, sha256_of_loader_prog);

    skel_map_get_hash(map_fd, NULL, 0);

    // Load the loader program (I_loader) with its signature.
    opts.ctx =3D (struct bpf_loader_ctx *)skel;
    opts.data_sz =3D sizeof(opts_data) - 1;
    opts.data =3D (void *)opts_data;
    opts.insns_sz =3D sizeof(opts_insn) - 1;
    opts.insns =3D (void *)opts_insn;

    opts.signature =3D =E2=80=A6 signature of the opts_insn[] bytes=E2=80=
=A6
    opts.signature_size =3D sizeof(..);
    opts. system_keyring_id  =3D ...

    OR

    opts.user_keyring_serial =3D =E2=80=A6 depending on what flag was used =
in bpftool.
    err =3D bpf_load_and_run(&opts);

The kernel verifier will:

    * Compute the hash of the provided I_loader bytecode.
    * Verify the signature against this computed hash.
    * Check if the metadata map (now exclusive) is intended for this
program's hash.

The signature check in the verifier (during BPF_PROG_LOAD):

    verify_pkcs7_signature(prog->aux->sha, sizeof(prog->aux->sha),
sig_from_bpf_attr, =E2=80=A6);

This ensures that the loaded loader program (I_loader), including the
embedded expected hash of the metadata (H_meta), is trusted.
Since the loader program is now trusted, it can be entrusted to verify
the actual metadata (M_metadata) read from the (now exclusive and
frozen) map against the embedded (and trusted) H_meta. There is no
Time-of-Check-Time-of-Use (TOCTOU) vulnerability here because:

    * The signature covers the I_loader and its embedded H_meta.
    * The metadata map M_metadata is frozen before the loader program
is loaded and associated with it.
    * The map is made exclusive to the specific (signed and verified)
loader program.

