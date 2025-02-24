Return-Path: <linux-kselftest+bounces-27333-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEAD0A41954
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 10:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A8D53AF842
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 09:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCF21FE46B;
	Mon, 24 Feb 2025 09:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="EwzBQAI5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBD678F2E;
	Mon, 24 Feb 2025 09:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740389947; cv=none; b=ra4IDYWYu2WeiA1cDMm+5eB+41/OfXrGXMdu3Xy9+m53GC3fSN0FIZYF4KIVZvfGQLyIciQZGGYOTOWwybDJf+CNNc449lCzpLWGTreQKUyopcY63C70XSAVnkRfhHAyFpOLxyliajqepQEEHV6g4h9smk2FDgqnJfImXXQNjOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740389947; c=relaxed/simple;
	bh=/HpH0//Sd9ANVoi0x2M7SEPliUKtNSAcq4jivyv/0Z0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TAn7AU+wqjWLbGMi0V5uHP72Zz79dYSbxhT10/Y0cVPUIPN7EVYblcvaVkpeuBNtE20VtBdOvucSA0V/FfW4V2fAFIFnM5BKWQT2sXSkTk+6GmhoIkjzdpFpwhmbRYDpj4iAsyITe7dh5zpzZDolCX6JnTpY/IqVE7MqgGIEkxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=EwzBQAI5; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1740389938; x=1740994738; i=ps.report@gmx.net;
	bh=rBw6xYsOHK0PSghpi+JD9vE8vBfcTAhCyiK4cG4ZtPM=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=EwzBQAI5W4GW7NjWUqX3x/kSnzdJGWK+fVeAIG3RwIrH2CWTJuKdrxNx5W+2RJnG
	 M/ZEA9t/pqNJAjnBsPqe9KnWpJG1BqsKhhmM01lEReMAHByYRlIRJ0HJWObz0ok3D
	 ci0ThekP6wjle6BJ6AEw2MIF6wT4H9GO06148tbr9HJEVMH0Nh+BI8Byxp++VBsz2
	 Op3GzyGmlc6GdvoJivOUVSbfQxj1oh8zh+V6boB47ikZ8GbLzYrI+m4B35wvlwszc
	 tO6aJbfbYHh+yOPwFWas7lDIvmulw4INvVyViv6Z8FltyWP9wYH5w/Otb5CZA185y
	 yFgKZFjkavV/BoS4DA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost ([82.135.81.227]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M3UZG-1tn2tE1ABu-00DwCy; Mon, 24
 Feb 2025 10:38:58 +0100
Date: Mon, 24 Feb 2025 10:38:56 +0100
From: Peter Seiderer <ps.report@gmx.net>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Artem Chernyshev <artem.chernyshev@red-soft.ru>,
 Frederic Weisbecker <frederic@kernel.org>, Nam Cao <namcao@linutronix.de>
Subject: Re: [PATCH net-next v7 1/8] net: pktgen: fix mix of int/long
Message-ID: <20250224103856.31dc0260@gmx.net>
In-Reply-To: <20250224092242.13192-2-ps.report@gmx.net>
References: <20250224092242.13192-1-ps.report@gmx.net>
	<20250224092242.13192-2-ps.report@gmx.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tisrOSfy4uCVTiyzps2E/dGQ4F2zlzbHDtizmbtjmAcn4nVKxyv
 XZ1eS2CyhWPPNl/fgHp4uGRNa/zvU1DzBVgoijD6BeivKwgwzDADhIhe2DVv6QgDQEy75rx
 GtLCQIdYHY8x9jnLy/Sjx77/uFBPGn+mJ7VuGewIHtFIT6qPLgrZkpF2zjzxAFg5qFoYBbH
 AM5U77NqVMLbIbFxDpXLQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AmSkhg488Mo=;iHJ7wqyPGccxdVNfniaDHrlnSjv
 z3GK1A0d6uwxgax1oFN+z31CkEZWbqcGaUFzG2MOATvgdDuDIKC7bDH4lKa3dPEQKoiQ01Uzg
 ueJU6FxX67/zPE2xH54Wz8YT5ZMouuu2ZlB3LzT/rLRVMQ/dxv+jYiVZ0d8Dm8UEDdFfkQOpL
 q2XBF//HcgYKYOylor+UYxQEEvsDUPdDLcrvaZgT+CWVRWibAKJiihxFbkafAQHQbl9tRqAbE
 QvFzE/Adt0YCxni1I9amxOtVRh2z/TSGVPW/KI3qFERrMeZOfA0aTR6+uRL9HBTVA9Bsnq5uH
 gMAD7CLAFx6dRBQldpobHmb+5agBboDOfhOREMcLMNYDUcRIq5zFqGHir3aa3d04aJHSK+ir4
 WJ59S7R0iWVWQN6QsFBBH4Y0Zc3wVF6HnbV81LG5gbitOw6tWfdfrsq1ezCPtHMNGw9wQuXkJ
 PdVW0S7IWnE2UTfV+9Ph+wZdfXcoviTa530kLpv1vsGKWL83ahTtzjZoTPAp0OJpnfakP+EtP
 2YMI17ff3yii1t5Lu4F3uU3YhGitxnJvkaMdCtTrHm0b/oKJArGY15p7rJ/TCORC0A53uYIOg
 7fhUelzRnPTcDT1YSt1G2zC+PnhD0qcIjj3qqttPtW0eUiUS4OrYyOqLnx0KNM3QC65VQ+AFc
 F0q35wNN2AE7zXttpMB9/NzXGURhZT5FPgJl6pmXjOrKMRhRDUFH9dFdFSnMFtkPFr++buLqP
 Y9xVIDzqRyN7O2XfffDPj8AiZteUQ2SZWvoWSZPaa7KJBsHvsKK1OBW8SHhwrLB/YxeZr8aFa
 yRuLYlFo+1nnCG1PPd38+aKsikqtrSlVoPyrECm8kRfF2yCqQtz/L0LK5PEWduAr4Wf3ixrUj
 CnvzlhBHekotbKA17U2v2wFMEN5U2oY0maQ1AIHMEpniXyTY2nQOWfxTGsTAFz4cM0MABsTpo
 8OcKFWyPoe6MIF2S9NQWTBx/+G4aiDDMvd12OA14zTsonsqCgQeZmj5oN27HakbsoWsr8gvr0
 te25PEIBQ6Vhyf5na8+3VgWe25QPNMZtRrDAdLD6HJ86M+DGOCNtrmJEriPOpprhHGQ+GUTa/
 BttVZkejqacglR/5BsXUtMYS2+VxFAOB0OmoPhB/Pe9UzUrQnuAgfKAYjrOW3gn+1iNmlBlY/
 ZTTL0YXgB5R3uDV5ylVKnAiHhGrdHVTQDPjN6TXozeNA5CYYD4EDRhD0txd/1w9jTaW2wvoX9
 10DB5yxSBccl+wgzepqGOCF4SNXeoBITJma8/XPcp5/bbGKVUp7v5zkBHDjXOgvgBS8sOHogY
 DlIVyokCsOhlkBEdS2b3aQVlBp+uCwxtElRgd+Vt/vIMMgIV3zQQtpfFj/Wt6ohpj40o7O8Bw
 EdRF3Tb0YqU8xzMCj1fTZdQ2Gsa41HlV06dM9OXeXtgzMKtnzZ8BwL2j7T

Hello *,

On Mon, 24 Feb 2025 10:22:35 +0100, Peter Seiderer <ps.report@gmx.net> wro=
te:

> Fix mix of int/long (and multiple conversion from/to) by using consequen=
tly
> size_t for i and max and ssize_t for len and adjust function signatures
> of hex32_arg(), count_trail_chars(), num_arg() and strn_len() accordingl=
y.
>
> Signed-off-by: Peter Seiderer <ps.report@gmx.net>

Actual missing the rev-by Simon Horman given for the v5 version of the
patch set (see [1]) and indicated in the change description v5->v6...

Regards,
Peter

[1] https://lore.kernel.org/netdev/20250216135748.GD1615191@kernel.org/

> ---
> Changes v6 -> v7
>   - rebased on actual net-next/main
>   - no changes
>
> Changes v5 -> v6
>   - adjust to dropped patch ''net: pktgen: use defines for the various
>     dec/hex number parsing digits lengths'
>   - add rev-by Simon Horman
>   - fix line break (suggested by Simon Horman)
>
> Changes v4 -> v5
>   - split up patchset into part i/ii (suggested by Simon Horman)
>   - instead of align to most common pattern (int) adjust all usages to
>     size_t for i and max and ssize_t for len and adjust function signatu=
res
>     of hex32_arg(), count_trail_chars(), num_arg() and strn_len() accord=
ingly
>   - respect reverse xmas tree order for local variable declarations (whe=
re
>     possible without too much code churn)
>   - update subject line and patch description
>   - fix checkpatch warning '"foo * bar" should be "foo *bar"' for
>     count_trail_chars() and strn_len()
>
> Changes v3 -> v4
>   - new patch (factored out of patch 'net: pktgen: fix access outside of=
 user
>     given buffer in pktgen_if_write()')
> ---
>  net/core/pktgen.c | 38 ++++++++++++++++++++------------------
>  1 file changed, 20 insertions(+), 18 deletions(-)
>
> diff --git a/net/core/pktgen.c b/net/core/pktgen.c
> index 55064713223e..cd6b6c0dc0dc 100644
> --- a/net/core/pktgen.c
> +++ b/net/core/pktgen.c
> @@ -746,10 +746,11 @@ static int pktgen_if_show(struct seq_file *seq, vo=
id *v)
>  }
>
>
> -static int hex32_arg(const char __user *user_buffer, unsigned long maxl=
en,
> -		     __u32 *num)
> +static ssize_t hex32_arg(const char __user *user_buffer, size_t maxlen,
> +			 __u32 *num)
>  {
> -	int i =3D 0;
> +	size_t i =3D 0;
> +
>  	*num =3D 0;
>
>  	for (; i < maxlen; i++) {
> @@ -768,10 +769,9 @@ static int hex32_arg(const char __user *user_buffer=
, unsigned long maxlen,
>  	return i;
>  }
>
> -static int count_trail_chars(const char __user * user_buffer,
> -			     unsigned int maxlen)
> +static ssize_t count_trail_chars(const char __user *user_buffer, size_t=
 maxlen)
>  {
> -	int i;
> +	size_t i;
>
>  	for (i =3D 0; i < maxlen; i++) {
>  		char c;
> @@ -793,10 +793,10 @@ static int count_trail_chars(const char __user * u=
ser_buffer,
>  	return i;
>  }
>
> -static long num_arg(const char __user *user_buffer, unsigned long maxle=
n,
> -				unsigned long *num)
> +static ssize_t num_arg(const char __user *user_buffer, size_t maxlen,
> +		       unsigned long *num)
>  {
> -	int i;
> +	size_t i;
>  	*num =3D 0;
>
>  	for (i =3D 0; i < maxlen; i++) {
> @@ -812,9 +812,9 @@ static long num_arg(const char __user *user_buffer, =
unsigned long maxlen,
>  	return i;
>  }
>
> -static int strn_len(const char __user * user_buffer, unsigned int maxle=
n)
> +static ssize_t strn_len(const char __user *user_buffer, size_t maxlen)
>  {
> -	int i;
> +	size_t i;
>
>  	for (i =3D 0; i < maxlen; i++) {
>  		char c;
> @@ -844,9 +844,9 @@ static int strn_len(const char __user * user_buffer,=
 unsigned int maxlen)
>  static ssize_t get_imix_entries(const char __user *buffer,
>  				struct pktgen_dev *pkt_dev)
>  {
> -	const int max_digits =3D 10;
> -	int i =3D 0;
> -	long len;
> +	const size_t max_digits =3D 10;
> +	size_t i =3D 0;
> +	ssize_t len;
>  	char c;
>
>  	pkt_dev->n_imix_entries =3D 0;
> @@ -895,9 +895,9 @@ static ssize_t get_imix_entries(const char __user *b=
uffer,
>  static ssize_t get_labels(const char __user *buffer, struct pktgen_dev =
*pkt_dev)
>  {
>  	unsigned int n =3D 0;
> +	size_t i =3D 0;
> +	ssize_t len;
>  	char c;
> -	ssize_t i =3D 0;
> -	int len;
>
>  	pkt_dev->nr_labels =3D 0;
>  	do {
> @@ -956,7 +956,8 @@ static ssize_t pktgen_if_write(struct file *file,
>  {
>  	struct seq_file *seq =3D file->private_data;
>  	struct pktgen_dev *pkt_dev =3D seq->private;
> -	int i, max, len;
> +	size_t i, max;
> +	ssize_t len;
>  	char name[16], valstr[32];
>  	unsigned long value =3D 0;
>  	char *pg_result =3D NULL;
> @@ -1883,7 +1884,8 @@ static ssize_t pktgen_thread_write(struct file *fi=
le,
>  {
>  	struct seq_file *seq =3D file->private_data;
>  	struct pktgen_thread *t =3D seq->private;
> -	int i, max, len, ret;
> +	size_t i, max;
> +	ssize_t len, ret;
>  	char name[40];
>  	char *pg_result;
>


