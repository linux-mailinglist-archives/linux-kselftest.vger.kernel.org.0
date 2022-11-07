Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1463E61FBB5
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Nov 2022 18:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbiKGRnK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 12:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbiKGRnF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 12:43:05 -0500
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D044224080
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Nov 2022 09:43:03 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 6C0CC240031
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Nov 2022 18:43:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1667842982; bh=3Zd2LzTn35gGPZH57ZQu9I2pZQgysxz4Yi4s55fsDAA=;
        h=Date:From:To:Cc:Subject:From;
        b=SPRH4rRUnoiSw1sMFZVGvbd4orWrduz7iu/JNsrZC07JbOcMP3A3OWNU+KbIliydx
         dwJIn0lrFX7IcE045BPxvTqFpBpZ1lqYuEDeCbwTGtPYUI1kI0TFenVGCEmoeOG5XE
         S1jpGNVvtiMkg2l6Xi2Bb8dGk/XfplNGgnkguDqdu7q7UrpJFK9kAn7W1crVaTmZjT
         h+Xb/eGTY6fD82Q5CrXsNQOU7hI1dA4QF8iYUldGtaYxC1xwCdtncmAcYD23DzaDa6
         PAX1iRDXxCH2zi/1xfPK6mskDp1ConSBCUscivKBJnYhK1r/vqrfkVt2kn7ocpoY5A
         90D7mKzHHhNAg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4N5dqM3Y1fz6tpl;
        Mon,  7 Nov 2022 18:42:55 +0100 (CET)
Date:   Mon,  7 Nov 2022 17:42:52 +0000
From:   Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
To:     Andrea Mayer <andrea.mayer@uniroma2.it>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefano Salsano <stefano.salsano@uniroma2.it>,
        Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
        Ahmed Abdelsalam <ahabdels.dev@gmail.com>
Subject: Re: [net] seg6: selftests/bpf: fix BPF object file name in
 test_lwt_seg6local.sh
Message-ID: <20221107174252.7ycgyedc575ojs4l@muellerd-fedora-PC2BDTX9>
References: <20221107143044.27763-1-andrea.mayer@uniroma2.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221107143044.27763-1-andrea.mayer@uniroma2.it>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Andrea,

On Mon, Nov 07, 2022 at 03:30:44PM +0100, Andrea Mayer wrote:
> The test_lwt_seg6local.c implements several eBPF programs which are
> used to test the SRv6 End.BPF behavior.
> Since commit afef88e65554 ("selftests/bpf: Store BPF object files with
> .bpf.o extension"), part of the build system and test programs loading
> BPF object files are supposed to work with the .bpf.o extension.
> 
> Consequently, the test_lwt_seg6local.c is compiled into
> test_lwt_seg6local.bpf.o and the corresponding test_lwt_seg6local.sh
> script is not updated to deal with the correct .bpf.o extension.
> 
> This patch fixes the test_lwt_seg6local.sh, using the correct .bpf.o
> extension for the testing BPF object file, i.e. test_lwt_seg6local.bpf.o.
> 
> Fixes: afef88e65554 ("selftests/bpf: Store BPF object files with .bpf.o extension")
> Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
> ---
>  tools/testing/selftests/bpf/test_lwt_seg6local.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/test_lwt_seg6local.sh b/tools/testing/selftests/bpf/test_lwt_seg6local.sh
> index 826f4423ce02..bfe76ab78481 100755
> --- a/tools/testing/selftests/bpf/test_lwt_seg6local.sh
> +++ b/tools/testing/selftests/bpf/test_lwt_seg6local.sh
> @@ -117,18 +117,18 @@ ip netns exec ${NS6} ip -6 addr add fb00::109/16 dev veth10 scope link
>  ip netns exec ${NS1} ip -6 addr add fb00::1/16 dev lo
>  ip netns exec ${NS1} ip -6 route add fb00::6 dev veth1 via fb00::21
>  
> -ip netns exec ${NS2} ip -6 route add fb00::6 encap bpf in obj test_lwt_seg6local.o sec encap_srh dev veth2
> +ip netns exec ${NS2} ip -6 route add fb00::6 encap bpf in obj test_lwt_seg6local.bpf.o sec encap_srh dev veth2
>  ip netns exec ${NS2} ip -6 route add fd00::1 dev veth3 via fb00::43 scope link
>  
>  ip netns exec ${NS3} ip -6 route add fc42::1 dev veth5 via fb00::65
> -ip netns exec ${NS3} ip -6 route add fd00::1 encap seg6local action End.BPF endpoint obj test_lwt_seg6local.o sec add_egr_x dev veth4
> +ip netns exec ${NS3} ip -6 route add fd00::1 encap seg6local action End.BPF endpoint obj test_lwt_seg6local.bpf.o sec add_egr_x dev veth4
>  
> -ip netns exec ${NS4} ip -6 route add fd00::2 encap seg6local action End.BPF endpoint obj test_lwt_seg6local.o sec pop_egr dev veth6
> +ip netns exec ${NS4} ip -6 route add fd00::2 encap seg6local action End.BPF endpoint obj test_lwt_seg6local.bpf.o sec pop_egr dev veth6
>  ip netns exec ${NS4} ip -6 addr add fc42::1 dev lo
>  ip netns exec ${NS4} ip -6 route add fd00::3 dev veth7 via fb00::87
>  
>  ip netns exec ${NS5} ip -6 route add fd00::4 table 117 dev veth9 via fb00::109
> -ip netns exec ${NS5} ip -6 route add fd00::3 encap seg6local action End.BPF endpoint obj test_lwt_seg6local.o sec inspect_t dev veth8
> +ip netns exec ${NS5} ip -6 route add fd00::3 encap seg6local action End.BPF endpoint obj test_lwt_seg6local.bpf.o sec inspect_t dev veth8
>  
>  ip netns exec ${NS6} ip -6 addr add fb00::6/16 dev lo
>  ip netns exec ${NS6} ip -6 addr add fd00::4/16 dev lo

The change looks good to me. Thanks for the fix.

Daniel

Acked-by: Daniel Müller <deso@posteo.net>
