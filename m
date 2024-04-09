Return-Path: <linux-kselftest+bounces-7498-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 339F889E1A1
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 19:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64B311C20BA0
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 17:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725DE156662;
	Tue,  9 Apr 2024 17:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kl5xzZIy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06E213C66C;
	Tue,  9 Apr 2024 17:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712683975; cv=none; b=B+JFcA9pdH5KYBkkrQvO6DAp86Vtrl/NTK/LmlyjEGbmB7LSSo01yQmKfSUg1W2JCjBFFtlxMP1cHWnS/1uIGOvkI2nlqa0n0mf7DFd04Sj4M7AAUohTWs8JmeOpJCum2EkVM3R77BI6RYxXkOAiCtFAM47ZdLrE+0PrjEtPGb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712683975; c=relaxed/simple;
	bh=pvYER4dRJ/VGQIx0PiTSl2MY3aF9wxxyJRSHBh1SVsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UZn/lsJKXFzIxYiCP1Xu9w2/FLBazT45DglIkwY5PJt0nhHHaZgcP4sTCcrT0Xik22QU19bce4UwsrL0AapbnkcCE7W6w1/JaIWq9Fknjwzy7LhSKUtsPJxFbp9c84yuYxTzAZmz7QnaEFrueQpk9gU7JcJAFd1X28rjDPzzy84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kl5xzZIy; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-343d1003106so3551930f8f.1;
        Tue, 09 Apr 2024 10:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712683972; x=1713288772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nUx9+hY0bK6SiTBKq1kx8pRnqhNPuAGSFb7TMAfJU4o=;
        b=Kl5xzZIymCUpUkLcSYhNbmFNYLlkU8j/XuOorkkPH/ME0FLw0upzSnwr2AWRH6818h
         Cc8WrLGFg1XmG/fx2EsGC+RtGtWcm+zbWM2EHhzJ22ND9l+Be7et6vLTKs4cTYDyfvSN
         vhvGXeGcD2eeQfh95M8//dLVjH/sv7J3eVuHRsnFEgjM4MhFS8ljQKDv+zfect7XdQDK
         d4HBngiEkbOW3L/jF1rQgX4+C2TO6XTuEu+vuoAzsUrHDIsww55oasQU3NHb8TXO2Pls
         /7qj39FKIN/139wQ/QzLls8WkMngwwCfVTUJ+2PrAOaSmzqmRoSthWnKY2l/fEEE8xOr
         lmJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712683972; x=1713288772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nUx9+hY0bK6SiTBKq1kx8pRnqhNPuAGSFb7TMAfJU4o=;
        b=OionSxUuJMM1v1/kXzcJxWnTpvBR355xk3zSbWnksZvQS/549jW7OYA0LrJ14qBKQD
         o3y2OO8Ma1iNFeeF7z4pSJsKfzVH/zyzrOQIWNtUr8W6j52+bwCK3YsXREiG9ynGvQrr
         2cJUMflVvIPx4dT4FjVy+Tout36OARatdE5zRlapvL9jD58Vo/AslKzcuTOb/cDB3vbG
         HKIFeb8shr4/k2BgPlg/KWWFLHStphbcBC2mh2LfqbMNQyXuMlZc2idkIdJ9z2B8UrqY
         f3dk01ts0twG2OXoWqyMjKyvhZX2nkq/k+2opr/JNUwuUvCsYkBEnn5+QXK0xIgLXbgb
         uVtg==
X-Forwarded-Encrypted: i=1; AJvYcCXY6t9vzWtFWPInai4wHKLCU0Z9uy272duuGdwOymRIzzkpwF/nYU2mORdxKAPac/61AenI3mpZHaQq1J7NeRTTR9dwnaQhR3TNBxM+0fsPF4EVX0jW9pyQT7VyLrSCct2bqxqu6Nx+f1uveGOUFolfFZ3Cu3gKEy0xBoyO
X-Gm-Message-State: AOJu0Ywa9XMi2um9rx/DsqkfHBet5CS03KIjEVZ24Mvw4wy6WM5xFYmn
	dWNyqT6YOTvoRFOJnDxFMb1DkUN4AffjNCVK9MB89/jtC7TVgacCJQr6vATTG59pUscwvnY433c
	OXPAdSW7b+Okck678enXGtvgUoFQ=
X-Google-Smtp-Source: AGHT+IHNT66RFzdFDDfN/XnceqYKqp3TaNrRe75TKPSz/6wWGE/cJp8py6SyauLHJzMFZjpa6t20T3WhJls2auiJpNo=
X-Received: by 2002:a5d:4e8f:0:b0:345:fd15:f035 with SMTP id
 e15-20020a5d4e8f000000b00345fd15f035mr275961wru.33.1712683971581; Tue, 09 Apr
 2024 10:32:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409031549.3531084-1-kuba@kernel.org> <20240409031549.3531084-4-kuba@kernel.org>
In-Reply-To: <20240409031549.3531084-4-kuba@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 9 Apr 2024 10:32:40 -0700
Message-ID: <CAADnVQ+Ux2i_58QhcpbMgKxMynGx5Sr_4qzTcGmqP+=7dq=fmw@mail.gmail.com>
Subject: Re: [PATCH net-next 3/4] selftests: net: declare section names for bpf_offload
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Network Development <netdev@vger.kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, bpf <bpf@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Eddy Z <eddyz87@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 8:17=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> Non-ancient ip (iproute2-5.15.0, libbpf 0.7.0) refuses to load
> the sample with maps because we don't generate BTF:
>
>    libbpf: BTF is required, but is missing or corrupted.
>    ERROR: opening BPF object file failed
>
> Enable BTF by adding -g to clang flags. With that done
> neither of the programs load:
>
>   libbpf: prog 'func': error relocating .BTF.ext function info: -22
>   libbpf: prog 'func': failed to relocate calls: -22
>   libbpf: failed to load object 'ksft-net-drv/net/sample_ret0.bpf.o'
>
> Andrii explains that this is because we don't specify
> section names for the code. Add the section names, too.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/testing/selftests/net/Makefile              | 3 ++-
>  tools/testing/selftests/net/bpf_offload.py        | 2 +-
>  tools/testing/selftests/net/sample_map_ret0.bpf.c | 2 +-
>  tools/testing/selftests/net/sample_ret0.bpf.c     | 3 +++
>  4 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftes=
ts/net/Makefile
> index e8bfa715aa49..a3c781cb8367 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -149,7 +149,8 @@ BPF_PROG_OBJS :=3D $(OUTPUT)/nat6to4.o $(OUTPUT)/xdp_=
dummy.o \
>         $(OUTPUT)/sample_map_ret0.bpf.o $(OUTPUT)/sample_ret0.bpf.o
>
>  $(BPF_PROG_OBJS): $(OUTPUT)/%.o : %.c $(BPFOBJ) | $(MAKE_DIRS)
> -       $(CLANG) -O2 --target=3Dbpf -c $< $(CCINCLUDE) $(CLANG_SYS_INCLUD=
ES) -o $@
> +       $(CLANG) -O2 -g --target=3Dbpf $(CCINCLUDE) $(CLANG_SYS_INCLUDES)=
 \
> +       -c $< -o $@
>
>  $(BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)              =
      \
>            $(APIDIR)/linux/bpf.h                                         =
      \
> diff --git a/tools/testing/selftests/net/bpf_offload.py b/tools/testing/s=
elftests/net/bpf_offload.py
> index 174dba1a48d3..76b53ac2c8c6 100755
> --- a/tools/testing/selftests/net/bpf_offload.py
> +++ b/tools/testing/selftests/net/bpf_offload.py
> @@ -237,7 +237,7 @@ def bpftool_prog_load(sample, file_name, maps=3D[], p=
rog_type=3D"xdp", dev=3DNone,
>  def ethtool(dev, opt, args, fail=3DTrue):
>      return cmd("ethtool %s %s %s" % (opt, dev["ifname"], args), fail=3Df=
ail)
>
> -def bpf_obj(name, sec=3D".text", path=3Dbpf_test_dir,):
> +def bpf_obj(name, sec=3D"xdp", path=3Dbpf_test_dir,):
>      return "obj %s sec %s" % (os.path.join(path, name), sec)
>
>  def bpf_pinned(name):
> diff --git a/tools/testing/selftests/net/sample_map_ret0.bpf.c b/tools/te=
sting/selftests/net/sample_map_ret0.bpf.c
> index 495990d355ef..43ca92594926 100644
> --- a/tools/testing/selftests/net/sample_map_ret0.bpf.c
> +++ b/tools/testing/selftests/net/sample_map_ret0.bpf.c
> @@ -17,7 +17,7 @@ struct {
>  } array SEC(".maps");
>
>  /* Sample program which should always load for testing control paths. */
> -SEC(".text") int func()
> +SEC("xdp") int func()

It bitrotted so much.. ouch.

For the series:
Acked-by: Alexei Starovoitov <ast@kernel.org>

