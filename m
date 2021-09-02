Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B62B23FF346
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Sep 2021 20:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241887AbhIBSdY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Sep 2021 14:33:24 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:48107 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230322AbhIBSdX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Sep 2021 14:33:23 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 054BA2B0063E;
        Thu,  2 Sep 2021 14:32:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 02 Sep 2021 14:32:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=h/Pl7Mb3FBXyVw4R078qSS32hJL
        8k+HdxwpVOKA9jmI=; b=Lpj5srDKuy4YwlHXMS0CxyuelYACm1zik5GXniwsKws
        leVMtaChmPvPQ1XDkdcznpM0P1fVJN2pPfK4lc+ISY7b0aUGKtg+JrKgGyqOM4C+
        7Ao1+PJeVJy/Mn+fwYxSCPfviP+aRobecOJXdbC7W8ebz+5jOMh4VVPApy5u4C0l
        +vbT6NL66o+rsHbXuTN+TrdhtoLrcwj4bwQUrWxJ7jFYH8K5IqOEPgS9HuEsv3OI
        +uWk9k7KF4bb08MnDgFPzCX7gI1l4GBJTb3ZhYU45r2paLF77l7G1a4lPD/zMvF0
        N1xWjl+Wio0JDh3Y6GjzeDsr0qobeBUXdMNU1T/enrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=h/Pl7M
        b3FBXyVw4R078qSS32hJL8k+HdxwpVOKA9jmI=; b=lHTVuZdjpkFPoQz6mexPrC
        lmzVRd2MuPQG6eX7SPaRu0PKYVvCUa+qL82OhmSh2zcRbR3j/eGuFOt4pcdjaE8g
        TkSXqAChpScRHqq5fC7DCK7R2OxBc0Iwg6QMbN55u07p950BARMt+vTbNvSzTRoX
        sI/yQqV+Slza6By2OncIX9+tTpPD25d9bmBCgXTL8GHD2th69sGQZ3APR59QLYWf
        DNcERGUobs3Uv5SwW9SbnbCK2jwv+9rC3VxghGqj4vY4De3uBqAW5MnlazVPy8IV
        RoiAE2Bo0IknQZoqih/c+v0s7Ttxi+Gg3MJpuNQ/arN2RWU9f/amHQmdBMQN8uuA
        ==
X-ME-Sender: <xms:thgxYaCmDBF00Tfs1Dcsfw-MtXTBXCC0ynjRMMb35P8JVanxE9DBtg>
    <xme:thgxYUjOjEN65eR6smaxzgqMECUYRC2W4NCg8Z1hN7Vvdn4EVIgL1GVnIHH4ZLnA7
    MugF4nxE7-NiIjjfg>
X-ME-Received: <xmr:thgxYdncCNYIPM944XIT25kBVmcjQY0mbF3RPxBmSZlVlgLf1sDueExdM0o0P8zhd0oKyscSTvBvPd1WL9kZu5WU2ooRgWUkCGdg5QF_YlUzmQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvhedguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdefhedmnegovfgvgihtqfhnlhihqddqigegudelqddvkeduucdl
    fedttddmnecujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpe
    ffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghr
    nhepueduvdejfefflefgueevheefgeefteefteeuudduhfduhfehveelteevudelheejne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhes
    ugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:thgxYYxqICP-w-fJ3v9iKqq5okisu-x2zd3Jxkcc5svwwOrb7afWPA>
    <xmx:thgxYfTp2vGZSC-xFycU8EeE4M4CPWR_SrsYo2qfnYi2Q7bpUdJmNA>
    <xmx:thgxYTZxPW4aF3dYSTnCXAiHh_F1tj_mrNFocPatG-gWEsgDrlf1QQ>
    <xmx:txgxYULhXzEcJ_10DGUHVAL-Ww0LkZP62T6x2JvdiXgKBFO3OKIZe31L9cJ5ULKf>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Sep 2021 14:32:21 -0400 (EDT)
Date:   Thu, 2 Sep 2021 11:32:20 -0700
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix build of task_pt_regs tests
 for arm64
Message-ID: <20210902183220.eu5ddkgnlakr7yw2@kashmir.localdomain>
References: <20210902090925.2010528-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902090925.2010528-1-jean-philippe@linaro.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 02, 2021 at 11:09:26AM +0200, Jean-Philippe Brucker wrote:
> struct pt_regs is not exported to userspace on all archs. arm64 and s390
> export "user_pt_regs" instead, which causes build failure at the moment:
> 
>   progs/test_task_pt_regs.c:8:16: error: variable has incomplete type 'struct pt_regs'
>   struct pt_regs current_regs = {};
> 
> Use the multi-arch macros defined by tools/lib/bpf/bpf_tracing.h to copy
> the pt_regs into a locally-defined struct.
> 
> Copying the user_pt_regs struct on arm64 wouldn't work because the
> struct is too large and the compiler complains about using too much
> stack.
> 
> Fixes: 576d47bb1a92 ("bpf: selftests: Add bpf_task_pt_regs() selftest")
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  .../selftests/bpf/bpf_pt_regs_helpers.h       | 30 +++++++++++++++++++
>  .../selftests/bpf/prog_tests/task_pt_regs.c   |  1 +
>  .../selftests/bpf/progs/test_task_pt_regs.c   | 10 ++++---
>  3 files changed, 37 insertions(+), 4 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/bpf_pt_regs_helpers.h

Acked-by: Daniel Xu <dxu@dxuuu.xyz>

[...]
