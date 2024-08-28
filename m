Return-Path: <linux-kselftest+bounces-16553-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1BD962AB8
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 16:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FECAB24222
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 14:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FAE19AD7E;
	Wed, 28 Aug 2024 14:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="eTcmeF3c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BCE18A93C
	for <linux-kselftest@vger.kernel.org>; Wed, 28 Aug 2024 14:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724856551; cv=none; b=Jurj4sLrKo8UJo3Wvs66QNrx+0CmaAL3yUgF5IVzT2/BaHiaA6D7wJXOUU+ixjMNqn33w9lcJSLsOOxtvq6y0Qxx+aqtgdW+vAxm83NgO2O2dRMtRn7Uqw8MISIxCEvvNjKyxVraAU49XbQPRsPm3l8KSYokAzoT9tkkof7pbnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724856551; c=relaxed/simple;
	bh=y7w88tbAC3MF8scuLZtp+00GfUJGmqknSk0uFjQqeU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o6LA+62jrms1tGxacVClv08Horcnw1tsM/XysTCxrDw7ILU2e1sAgTpp72iSKe5VkoyT+vqtivFbdBwKbGmzVr7QkhYjPMDxdoqXfJ/Ky/469JQIzMGyfLH8hfXywxa1yJ5cH0JIR5phxufiILeNzDj8184W927RYUeJC6aqGZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=eTcmeF3c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E4A0C4FF65;
	Wed, 28 Aug 2024 14:49:10 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="eTcmeF3c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1724856548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=weZ5k6SMmu2m7HJ7jHYcKzW5jeKRliJxJINVXaCKlQk=;
	b=eTcmeF3cVkBOwfs+KGf+Vf9d3mCfbdgBikncBMG1ZuFvgdcAZcySaT1JxG+MaS8TFUi3zu
	wa+3AcGpwDvP4qGS7iI6JAVp8m1VhH2sy1mG2JGis/tEwOzQBQ7pxYA818gCgf+X+p5nZ1
	axkL/l38LQzmupnukILGQ9TJzBh1JGk=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 23502d85 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 28 Aug 2024 14:49:08 +0000 (UTC)
Date: Wed, 28 Aug 2024 16:49:05 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: LEROY Christophe <christophe.leroy2@cs-soprasteria.com>
Cc: "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"xry111@xry111.site" <xry111@xry111.site>,
	"adhemerval.zanella@linaro.org" <adhemerval.zanella@linaro.org>
Subject: Re: [PATCH] selftests/vDSO: open code basic chacha instead of
 linking to libsodium
Message-ID: <Zs844SsY-zP2kSTc@zx2c4.com>
References: <20240828135510.3414909-1-Jason@zx2c4.com>
 <64761aa8-123b-4eeb-890a-855d0a0f8755@cs-soprasteria.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <64761aa8-123b-4eeb-890a-855d0a0f8755@cs-soprasteria.com>

Hi Christophe,

On Wed, Aug 28, 2024 at 4:38 PM LEROY Christophe <christophe.leroy2@cs-soprasteria.com> wrote:
> -               key[0], key[1], key[2], key[3], key[4], key[5], key[6], key[7]
> +               le32toh(key[0]), le32toh(key[1]), le32toh(key[2]), le32toh(key[3]),
> +               le32toh(key[4]), le32toh(key[5]), le32toh(key[6]), le32toh(key[7])

Are you sure about that?

From drivers/char/random.c:

static void _get_random_bytes(void *buf, size_t len)
{
        u32 chacha_state[CHACHA_STATE_WORDS];
	...
        crng_make_state(chacha_state, buf, first_block_len);
	...
        while (len) {
                if (len < CHACHA_BLOCK_SIZE) {
                        chacha20_block(chacha_state, tmp);

static void crng_make_state(u32 chacha_state[CHACHA_STATE_WORDS],
                            u8 *random_data, size_t random_data_len)
{
	...
	crng_fast_key_erasure(base_crng.key, chacha_state,
			      random_data, random_data_len);
	...
	  crng_fast_key_erasure(base_crng.key, chacha_state,
		      crng->key, sizeof(crng->key));

static void crng_fast_key_erasure(u8 key[CHACHA_KEY_SIZE],
                                  u32 chacha_state[CHACHA_STATE_WORDS],
                                  u8 *random_data, size_t random_data_len)
{
        u8 first_block[CHACHA_BLOCK_SIZE];

        BUG_ON(random_data_len > 32);

        chacha_init_consts(chacha_state);
        memcpy(&chacha_state[4], key, CHACHA_KEY_SIZE);
        memset(&chacha_state[12], 0, sizeof(u32) * 4);
        chacha20_block(chacha_state, first_block);

        memcpy(key, first_block, CHACHA_KEY_SIZE);
        memcpy(random_data, first_block + CHACHA_KEY_SIZE, random_data_len);
        memzero_explicit(first_block, sizeof(first_block));
}

And then if we look at chacha20_block->chacha_block_generic in
lib/crypto/chacha.c:

void chacha_block_generic(u32 *state, u8 *stream, int nrounds)
{
        u32 x[16];
        int i;

        memcpy(x, state, 64);

        chacha_permute(x, nrounds);

        for (i = 0; i < ARRAY_SIZE(x); i++)
                put_unaligned_le32(x[i] + state[i], &stream[i * sizeof(u32)]);

        state[12]++;
}

So I don't see any endianness conversion happening with the key bytes.
They're memcpy'd from rng output bytes directly into native endian u32
words.

You may have an objection to this. But the goal of the vDSO code is to
match the kernel's algorithm 1:1 without deviations. To that end, I
suspect this patch actually improves the unit test to ensure that.

With regards to your objection, though, if you feel strongly enough
about it, I suppose that's something you could attempt to change
throughout, with one commit that touches random.c and the vDSO code. I'm
not sure whether or not I'd go along with that yet, but if it were to
happen, I think that's the way to do it. For now, though, the goal is
for the vDSO algorithm to copy the kernel algorithm.

Do you agree that this patch helps the vDSO algorithm copy the kernel
algorithm better? Genuinely asking, because maybe I got it all backwards
somehow.

Jason

