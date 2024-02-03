Return-Path: <linux-kselftest+bounces-4114-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 301EE84883E
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Feb 2024 19:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D5D31F23313
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Feb 2024 18:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BB55FDB3;
	Sat,  3 Feb 2024 18:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XINpu29U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1A85F561;
	Sat,  3 Feb 2024 18:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706985949; cv=none; b=W+vl9/d2F0dIN8HYxHPJNts8lWTa5fnHufwGQ3XcGq9JNi92MJFHLWzbAa0QbtGCk4JDYRapa2a8HaETYotcX+56RIX7hKQWtOwUmUtoKIku3XIUpzEpZ5yCA6AnnJl288zytfldr4OESndx66KoXqQWRXQFEKL88s3ZYKIwd1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706985949; c=relaxed/simple;
	bh=QLmB+a7rMrDFXLv1SPoxkXPhzSnXnhs+odqRkVdXqM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s46g8JixVOhMePYuN/Uu3+YkMV6ID/jgUZouXv/In3lkhpg7B5a6zrDNpKgt4Tj2geCD509fCIDRjBjoZlWs3yR4YjV/L8BU9LFuTyRtv19w8D3q5wVqLdZs9HIy/4u6BWde58asVNsf4BAbqSDUjVzdyuutLWnD8z8y4JzX4cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XINpu29U; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-204f50f305cso2033081fac.3;
        Sat, 03 Feb 2024 10:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706985938; x=1707590738; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y0N/TxnXN2qBHJ/dkfZVj0nsBZc+7pjCqkkafHOcTPY=;
        b=XINpu29UxWjy09y+rCAxh2r+t2LPxjy3x9XN2MqmGFc0RIug/fXsdQ8pezTPDuUVHb
         lgwfPBQeaedIOx7oK7u75/ytyxkKxALmiLFGDIhN8OhHJ4bhNE0tIWskvTqxQgGCQg4K
         lOaTJYwQvfxxt9fmWTQuoqErvjng9hthjUEcvQZxnDKUy0V6STp4+KnMhwlgLgA5BpaL
         yzxm2KOG93M07WrWV5P2894+57wOJZ/bhnTeGIudVr65at1wWqDiy4bFRPIO+q/2FETa
         Hll3q6V2j4LD1mI1Qnpt9bS2tYS5fdiK4UHOqQfx8aupdESlJ5wW+2yDrQgWPtjsQNSR
         LpXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706985938; x=1707590738;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y0N/TxnXN2qBHJ/dkfZVj0nsBZc+7pjCqkkafHOcTPY=;
        b=opJN4U2rdtocW5uzA3YWe5dxlcW+fzOtrUb/gvknJPr0sQ8OvzGtMZ8mTSmK1eXpg6
         fYMD2dBiapkH3QQBoiELwNSMV2hLg7q9EZlTWQLP96/bsKDWXOKk+Cm57QNNafnjdW4+
         +qra3Y17p12x7Egr2XHIrBGKD9+3bEKmBSzh7oTcKY7JeupOm2+lcFSGiVK1mFxgKbZz
         BZzUi9mjc73/Ch7MWe3uX9eD2GCXe2qDjM+kAZZTWeE+rufJ2deup3/pSDIBajbGOmcX
         z+i/chuuAjGmAQMz193SlDRlC/aP78MJL+Ck08Dbj4ucfPo+C0n9M7w+4zr9XWaY84oZ
         Mdsw==
X-Gm-Message-State: AOJu0YxxAy0vA+sx5dAqDWmnZ/b/AiR+AGSaOT6wEabeEGepESR0LQkd
	VPrGgacbeTVOJ9YP3X0I1r6F6treRD4v69yW75bgGZtMl/gsqShc
X-Google-Smtp-Source: AGHT+IE6cTsFsYxec6Cc2Nv8r8Wv7UwdJ2OkD0GT9fp4iaKTaMhjHiWk6mQDIasAcDiqRAsVsbikAg==
X-Received: by 2002:a05:6870:4149:b0:214:ff12:3dda with SMTP id r9-20020a056870414900b00214ff123ddamr3816197oad.2.1706985938425;
        Sat, 03 Feb 2024 10:45:38 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUQOTzlsO8lgt6pTwZLPw4119LfUrIfiaPa1wTTfdoxvsVTK1OcV2Dhbg5b2iobZcoC99Y+nA1mfBlqm8ccNuDEZ9ovSOSxF3dHJJoFa8pVW2wvNSbjP7RHN1nQlbwYiR+ZGUGPHsYbVIKUu/kExr3+mBS2LyoL7EMCy0RKTBCwZmgSJAnm8YjNjZATBXumi5rZ1guYYVe6tbB3apJ1FiMecZeZOLFGPHLSIm9lMMnedLrSL5LR+ITrAlKqzgfOzWbsLuUM4d0ufoM4ZdW8uS+lgajFrBnb5Unl8KMrPo5f7fVRDTzb+mpkXuSEfXp+VxBl9aBdT1X4Pu6RO2Vb+J9irkfLOt6ydfNho4jZIfhH5e7RejlM3xop2REcBU+7Ep2QxW6BfVclBjRvfADINXaS9e2RfWdRXu9F1/Yl7W4aoQMsEnydZd5izTj9tgYTVMJznLUUlABQlG1XUF+lALvWG6wGjF/JBqJwIeKsgiHWrSlTkPAQMEc11zIv9TBj/SgdR+1IGkyuC42IrbIYBRA6Lh1HyFcyKl9okR8mk02mHyKzcQcLfR3w3JL3Ur9d5SVkncclHqL1PxkDpGPOs3dE++/rIX2sEot24DS//9lxdPUpALKMpt4xa0iv27eylxppX5U6yH5xrfrThO7kAWWBey3QFiyYH1/6c0o0YhJJldRm9x6QOyyQUBjy8xYN3sw+NkNgjLDcwTs+DRby93OBGQ==
Received: from surya ([70.134.61.176])
        by smtp.gmail.com with ESMTPSA id g37-20020a635665000000b005d748902a01sm3945514pgm.43.2024.02.03.10.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 10:45:37 -0800 (PST)
Date: Sat, 3 Feb 2024 10:45:11 -0800
From: Manu Bretelle <chantr4@gmail.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: vmalik@redhat.com, Daniel Xu <dxu@dxuuu.xyz>,
	linux-trace-kernel@vger.kernel.org, coreteam@netfilter.org,
	bpf@vger.kernel.org, linux-input@vger.kernel.org,
	cgroups@vger.kernel.org, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	fsverity@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	netfilter-devel@vger.kernel.org, alexei.starovoitov@gmail.com,
	quentin@isovalent.com, alan.maguire@oracle.com, memxor@gmail.com
Subject: Re: [PATCH bpf-next v4 0/3] Annotate kfuncs in .BTF_ids section
Message-ID: <Zb6Jt30bNcNhM6zR@surya>
References: <cover.1706491398.git.dxu@dxuuu.xyz>
 <Zb12EZt0BAKOPBk/@surya>
 <Zb5QWCw3Tg26_MDa@krava>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zb5QWCw3Tg26_MDa@krava>

On Sat, Feb 03, 2024 at 03:40:24PM +0100, Jiri Olsa wrote:
> On Fri, Feb 02, 2024 at 03:09:05PM -0800, Manu Bretelle wrote:
> > On Sun, Jan 28, 2024 at 06:24:05PM -0700, Daniel Xu wrote:
> > > === Description ===
> > > 
> > > This is a bpf-treewide change that annotates all kfuncs as such inside
> > > .BTF_ids. This annotation eventually allows us to automatically generate
> > > kfunc prototypes from bpftool.
> > > 
> > > We store this metadata inside a yet-unused flags field inside struct
> > > btf_id_set8 (thanks Kumar!). pahole will be taught where to look.
> > > 
> > > More details about the full chain of events are available in commit 3's
> > > description.
> > > 
> > > The accompanying pahole and bpftool changes can be viewed
> > > here on these "frozen" branches [0][1].
> > > 
> > > [0]: https://github.com/danobi/pahole/tree/kfunc_btf-v3-mailed
> > > [1]: https://github.com/danobi/linux/tree/kfunc_bpftool-mailed
> > 
> > 
> > I hit a similar issue to [0] on master
> > 943b043aeecc ("selftests/bpf: Fix bench runner SIGSEGV")
> >  when cross-compiling on x86_64 (LE) to s390x (BE).
> > I do have CONFIG_DEBUG_INFO_BTF enable and the issue would not trigger if
> > I disabled CONFIG_DEBUG_INFO_BTF (and with the fix mentioned in [0]).
> > 
> > What seems to happen is that `tools/resolve_btfids` is ran in the context of the
> > host endianess and if I printk before the WARN_ON:
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index ef380e546952..a9ed7a1a4936 100644
> >   --- a/kernel/bpf/btf.c
> >   +++ b/kernel/bpf/btf.c
> >   @@ -8128,6 +8128,7 @@ int register_btf_kfunc_id_set(enum bpf_prog_type prog_type,
> >            * WARN() for initcall registrations that do not check errors.
> >            */
> >           if (!(kset->set->flags & BTF_SET8_KFUNCS)) {
> >   +        printk("Flag 0x%08X, expected 0x%08X\n", kset->set->flags, BTF_SET8_KFUNCS);
> >                   WARN_ON(!kset->owner);
> >                   return -EINVAL;
> >           }
> > 
> > the boot logs would show:
> >   Flag 0x01000000, expected 0x00000001
> > 
> > The issue did not happen prior to
> > 6f3189f38a3e ("bpf: treewide: Annotate BPF kfuncs in BTF")
> > has only 0 was written before.
> > 
> > It seems [1] will be addressing cross-compilation, but it did not fix it as is
> > by just applying on top of master, so probably some of the changes will also need
> > to be ported to `tools/include/linux/btf_ids.h`?
> 
> the fix in [1] is fixing flags in set8's pairs, but not the global flags
> 
> it looks like Viktor's fix should now also swap that as well? like in the
> change below on top of Viktor's changes (untested)
> 
> jirka
> 
> 
> ---
> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
> index d01603ef6283..c44d57fec390 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c
> @@ -706,6 +706,8 @@ static int sets_patch(struct object *obj)
>  			 * correctly translate everything.
>  			 */
>  			if (need_bswap) {
> +				set8->flags = bswap_32(set8->flags);
> +
>  				for (i = 0; i < cnt; i++) {
>  					set8->pairs[i].flags =
>  						bswap_32(set8->pairs[i].flags);
> 

That should work. Here are a few tests I ran:

$ md5sum /tmp/kbuild-s390x/vmlinux.*
eb658e51e089f3c5b2c8909a29dc9997  /tmp/kbuild-s390x/vmlinux.a
# plain vmlinux before running resolv_btfids (all 0s)
ea907cd46a1a73b8276b5f2a82af00ca  /tmp/kbuild-s390x/vmlinux.before_resolv
# x86_64 resolv_btfids on master without Viktor's patch
980a40c3a3ff563d1c2d1ebdd5071a23  /tmp/kbuild-s390x/vmlinux.resolv_native
# x86_64 resolv_btfids on master with Viktor's patch
b986d19e242719ebea41c578235da662  /tmp/kbuild-s390x/vmlinux.resolv_native_patch_viktor
# x86_64 resolv_btfids on master with Viktor's patch and your suggested patch
4edd8752ff01129945bd442689b1927b  /tmp/kbuild-s390x/vmlinux.resolv_native_patch_viktor_patched
# s390x resolv_btfids run with qemu-s390x-static
4edd8752ff01129945bd442689b1927b  /tmp/kbuild-s390x/vmlinux.resolv_s390x


and some hexdiff of those binaries:


# difference between master's native build and s390x build.... has byte swapping for set8 and others
diff -ruN <(xxd /tmp/kbuild-s390x/vmlinux.resolv_s390x) <(xxd /tmp/kbuild-s390x/vmlinux.resolv_native) > diff_s390x_native.diff
https://gist.github.com/chantra/c3d58637a08a6f7340953dc155bb18cc

# difference betwee Viktor's version and  s390x build.... squinting my eyes I only see the global set8 is missing
diff -ruN <(xxd /tmp/kbuild-s390x/vmlinux.resolv_s390x) <(xxd /tmp/kbuild-s390x/vmlinux.resolv_native_patch_viktor) > diff_s390x_native_viktor.diff
https://gist.github.com/chantra/61cfff02b456ae72d3c0161ce1897097

Have a good weekend all!

Manu

