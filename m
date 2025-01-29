Return-Path: <linux-kselftest+bounces-25386-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B10A22346
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 18:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 075401886052
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 17:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024061DDC3B;
	Wed, 29 Jan 2025 17:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="neLkziuV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dfIvhfSv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BDC1922D3;
	Wed, 29 Jan 2025 17:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738172723; cv=none; b=LPZ2bNPf58rPi8QAAcgWMfg8EKIPrCE+YEi361xcnpb0IdmDZhehhgfC9haI81XY52sqofQ62QvGbfzxOcQ4ieI85+nrxIs+AeHfEm2/0izlANFxLoZas821y3ylWlXP1TR4hObmnzqieMmFTuP6zbjr2JBz7pmUyKn5xIu2snQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738172723; c=relaxed/simple;
	bh=s98cIhbXBXESd/Dodta9xIfcGjQ5stfBTvta0Rdmsig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pN5RGqa8ui9jLQrE6Y0aU6Gyq6HdxKexAzEyJzoZaCwXw9dprosH/UfaBvXvhti5+HVFLRdbIk/dWoahMjRzIH4UIoBTrvFN7d/8bQfRGn8qX+ERND0f8K5YAnVpM9Waz4eNKWTXxGsew9p7OV5QNIWxNPMVvSLqUINqJtDE6Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=neLkziuV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dfIvhfSv; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id C72B11380061;
	Wed, 29 Jan 2025 12:45:20 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 29 Jan 2025 12:45:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1738172720;
	 x=1738259120; bh=IqyjXNoWUVJhoEmd9c0TNjMsCqEKY7goUP5H7EhX1CI=; b=
	neLkziuVMTO3ZlsKsJe/IEnosPGzMZieRIstHLecoK8xeaNeaEZx4Y3fd62+Y0PE
	Dfk+XES7nXJoDykw2FbTRqerb5NGQYDgozBuYR05l7756N3KDocOCIzQUae1LPM0
	Kj1F5A4Cwm/39KoPTz5KFERsp4eF3NtuxY1XOjyL0xb0l1GBmJr2B2ohaUgrnUu0
	v22+AmcNu5LBtgrbX1iyScPRz6D26SvXd9EXf5Lmj4dKNEgB4purEle1UvZFDZPH
	oY1ePVEaVoKR8K7YTLG2TfUIzKAAZ0bbOGk2hLGrUsFSEyn+XznidVHpLAIUovMA
	y3ZsQz23omXOc9og0dqlHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738172720; x=
	1738259120; bh=IqyjXNoWUVJhoEmd9c0TNjMsCqEKY7goUP5H7EhX1CI=; b=d
	fIvhfSvvjUT3A9fflbhhWZiedpyiuHeJ27Zmk95P5zeSc9gx9XX+WvJDXfoF/3oA
	98KRz6ARfTpSFGz5g2zqp2WiXz5j+gird6blFj0iddarTI9prD2pmOzP7usUJDsz
	8uDQMACTIkVDtCr+5IpacMLAueHMbL8GRlBuohdXkl1EnfUKIREy+RBCClr76Imj
	45gk/bi7MZKjb6BoFvt6aj3sshfsnO2JN+/8iJ0u4Dqji1cpBtRRZc2TL0yw7Ltd
	QWJOSdYcQIuoP+5sSFovVTkGiIkVHk0gbhYQ0SGPNZ3hOeKPZp4pxV0zBka1CDx9
	TREVjOl9dnDbqrqBA9hCA==
X-ME-Sender: <xms:L2maZ1NJ2zPOgnF4iI0qdS8Wb7eO2ux7oN11UIKVR7ZHT78XkkIykQ>
    <xme:L2maZ3_muPJ59ct5sylOLbr_DHP6vwwGDyDX6Kpq5EmVE2KEcBmi39e4Lzm6a2gDo
    -R1-9s9oYf-vY1AbQ>
X-ME-Received: <xmr:L2maZ0SWRA7HRUpZuOzSyKGoAzH5oTUpf_rA3_GyG5ft5UWcqBGBi0IA5jr540U6kzwUJRjzyIlSYmpxeR0gn05nBUYSvGOJMbmr8I-l2vCh7w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegfrhhlucfvnfffucdlfeehmdenucfjughrpeffhffvvefukfhf
    gggtugfgjgestheksfdttddtudenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihuse
    gugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeeuhedtkedttddvieeffedtvdej
    udeuleefuedukeekteetffevleeglefhhfekueenucffohhmrghinhepghhithhhuhgsrd
    gtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    ugiguhesugiguhhuuhdrgiihiidpnhgspghrtghpthhtohepudelpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehiihhisehlihhnuhigrdhisghmrdgtohhmpdhrtghpthht
    ohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguugihiiekjeesgh
    hmrghilhdrtghomhdprhgtphhtthhopegrshhtsehkvghrnhgvlhdrohhrghdprhgtphht
    thhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhopegrnhgurh
    hiiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhhnrdhfrghsthgrsggvnhgu
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrrhhtihhnrdhlrghusehlihhnuhigrd
    guvghvpdhrtghpthhtohepshhonhhgsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:L2maZxt_yHWdgnu_O1BcmM1XBxfnZabd5UUJHb_p2s2TTtRvISawXg>
    <xmx:L2maZ9ckuBuYUOYkQ7nFfJRyrWxdqZfyJ-44fnS2NxFB_wRGSqWqxQ>
    <xmx:L2maZ911myeRLyVVlkbtC2D_gkAb_W6m-V-UfuysY7lMYWCD-8wo7A>
    <xmx:L2maZ59Ob0nrqE459VdTNsZFcQ1u1ZKI5SJGAp9n3lh9bSvdVmx6nw>
    <xmx:MGmaZ-AJsJT0WNGq73v5bIvAa3xFHn8w6OcVx4b-XDb5C8mu_ZH6QgUp>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jan 2025 12:45:17 -0500 (EST)
Date: Wed, 29 Jan 2025 10:45:16 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: shuah@kernel.org, eddyz87@gmail.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Marc Hartmayer <mhartmay@linux.ibm.com>
Subject: Re: [PATCH bpf-next v7 4/5] bpf: verifier: Support eliding map
 lookup nullness
Message-ID: <f7rhmwrp3fgx3qd7gn3pzczxeztvsg45u4vrl6ls3ylcvflapx@3yi3shfnrmb3>
References: <cover.1736886479.git.dxu@dxuuu.xyz>
 <68f3ea96ff3809a87e502a11a4bd30177fc5823e.1736886479.git.dxu@dxuuu.xyz>
 <78b2e750b4568e294b5fc5a33cf4bc8f62fae7f6.camel@linux.ibm.com>
 <hsgmutuoi4kvjkr7erm5ty2fdrhdrjpz4fpp5doe65l3pzguxv@lcbmvmjpyykq>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <hsgmutuoi4kvjkr7erm5ty2fdrhdrjpz4fpp5doe65l3pzguxv@lcbmvmjpyykq>

On Wed, Jan 29, 2025 at 09:49:12AM -0700, Daniel Xu wrote:
> Hi Ilya,
> 
> On Wed, Jan 29, 2025 at 03:58:54PM +0100, Ilya Leoshkevich wrote:
> > On Tue, 2025-01-14 at 13:28 -0700, Daniel Xu wrote:
> > > This commit allows progs to elide a null check on statically known
> > > map
> > > lookup keys. In other words, if the verifier can statically prove
> > > that
> > > the lookup will be in-bounds, allow the prog to drop the null check.
> > > 
> > > This is useful for two reasons:
> > > 
> > > 1. Large numbers of nullness checks (especially when they cannot
> > > fail)
> > >    unnecessarily pushes prog towards BPF_COMPLEXITY_LIMIT_JMP_SEQ.
> > > 2. It forms a tighter contract between programmer and verifier.
> > > 
> > > For (1), bpftrace is starting to make heavier use of percpu scratch
> > > maps. As a result, for user scripts with large number of unrolled
> > > loops,
> > > we are starting to hit jump complexity verification errors.  These
> > > percpu lookups cannot fail anyways, as we only use static key values.
> > > Eliding nullness probably results in less work for verifier as well.
> > > 
> > > For (2), percpu scratch maps are often used as a larger stack, as the
> > > currrent stack is limited to 512 bytes. In these situations, it is
> > > desirable for the programmer to express: "this lookup should never
> > > fail,
> > > and if it does, it means I messed up the code". By omitting the null
> > > check, the programmer can "ask" the verifier to double check the
> > > logic.
> > > 
> > > Tests also have to be updated in sync with these changes, as the
> > > verifier is more efficient with this change. Notable, iters.c tests
> > > had
> > > to be changed to use a map type that still requires null checks, as
> > > it's
> > > exercising verifier tracking logic w.r.t iterators.
> > > 
> > > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > > ---
> > >  kernel/bpf/verifier.c                         | 92
> > > ++++++++++++++++++-
> > >  tools/testing/selftests/bpf/progs/iters.c     | 14 +--
> > >  .../selftests/bpf/progs/map_kptr_fail.c       |  2 +-
> > >  .../selftests/bpf/progs/verifier_map_in_map.c |  2 +-
> > >  .../testing/selftests/bpf/verifier/map_kptr.c |  2 +-
> > >  5 files changed, 99 insertions(+), 13 deletions(-)
> > 
> > [...]
> > 
> > > @@ -9158,6 +9216,7 @@ static int check_func_arg(struct
> > > bpf_verifier_env *env, u32 arg,
> > >  	enum bpf_arg_type arg_type = fn->arg_type[arg];
> > >  	enum bpf_reg_type type = reg->type;
> > >  	u32 *arg_btf_id = NULL;
> > > +	u32 key_size;
> > >  	int err = 0;
> > >  
> > >  	if (arg_type == ARG_DONTCARE)
> > > @@ -9291,8 +9350,13 @@ static int check_func_arg(struct
> > > bpf_verifier_env *env, u32 arg,
> > >  			verbose(env, "invalid map_ptr to access map-
> > > >key\n");
> > >  			return -EACCES;
> > >  		}
> > > -		err = check_helper_mem_access(env, regno, meta-
> > > >map_ptr->key_size,
> > > -					      BPF_READ, false,
> > > NULL);
> > > +		key_size = meta->map_ptr->key_size;
> > > +		err = check_helper_mem_access(env, regno, key_size,
> > > BPF_READ, false, NULL);
> > > +		if (err)
> > > +			return err;
> > > +		meta->const_map_key = get_constant_map_key(env, reg,
> > > key_size);
> > > +		if (meta->const_map_key < 0 && meta->const_map_key
> > > != -EOPNOTSUPP)
> > > +			return meta->const_map_key;
> > 
> > Mark Hartmayer reported a problem that after this commit the verifier
> > started refusing to load libvirt's virCgroupV2DevicesLoadProg(), which
> > contains the following snippet:
> > 
> > 53: (b7) r1 = -1                      ; R1_w=-1
> > 54: (7b) *(u64 *)(r10 -8) = r1        ; R1_w=-1 R10=fp0 fp-8_w=-1
> > 55: (bf) r2 = r10                     ; R2_w=fp0 R10=fp0
> > 56: (07) r2 += -8                     ; R2_w=fp-8
> > 57: (18) r1 = 0x9553c800              ; R1_w=map_ptr(ks=8,vs=4)
> > 59: (85) call bpf_map_lookup_elem#1
> > 
> > IIUC here the actual constant value is -1, which this code confuses
> > with an error.
> 
> Thanks for reporting. I think I know what the issue is - will send a
> patch shortly.
> 
> Daniel
> 

I cribbed the source from [0] and tested before and after. I think this
should work. Mind giving it a try?

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9971c03adfd5..e9176a5ce215 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9206,6 +9206,8 @@ static s64 get_constant_map_key(struct bpf_verifier_env *env,
        return reg->var_off.value;
 }

+static bool can_elide_value_nullness(enum bpf_map_type type);
+
 static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
                          struct bpf_call_arg_meta *meta,
                          const struct bpf_func_proto *fn,
@@ -9354,9 +9356,11 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
                err = check_helper_mem_access(env, regno, key_size, BPF_READ, false, NULL);
                if (err)
                        return err;
-               meta->const_map_key = get_constant_map_key(env, reg, key_size);
-               if (meta->const_map_key < 0 && meta->const_map_key != -EOPNOTSUPP)
-                       return meta->const_map_key;
+               if (can_elide_value_nullness(meta->map_ptr->map_type)) {
+                       meta->const_map_key = get_constant_map_key(env, reg, key_size);
+                       if (meta->const_map_key < 0 && meta->const_map_key != -EOPNOTSUPP)
+                               return meta->const_map_key;
+               }
                break;
        case ARG_PTR_TO_MAP_VALUE:
                if (type_may_be_null(arg_type) && register_is_null(reg))

Thanks,
Daniel


[0]: https://github.com/libvirt/libvirt/blob/c1166be3475a0269f5164d87fec6227d6cb34b47/src/util/vircgroupv2devices.c#L66-L135

