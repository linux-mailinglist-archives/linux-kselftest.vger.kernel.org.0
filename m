Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F50A5A2C40
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Aug 2022 18:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbiHZQYK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Aug 2022 12:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiHZQYJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Aug 2022 12:24:09 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD60FDEB5A;
        Fri, 26 Aug 2022 09:24:08 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id d6so1087018ilg.4;
        Fri, 26 Aug 2022 09:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc;
        bh=IUW6YYxCAwdeHRIHDx1yJO8lcR2yG3Z47f18rm6Y2Ro=;
        b=OvIq6T03P+NTrSDcUoFa/6Fi+S+JsxZPNtqt4yjfXVdoyv0PKcbOF/vfj2VR6kcDzz
         1R3rdKb7zCDeZPBkQoem8oviOjpn2Z2eNTvYOGucDmKmHNHAP8nHWoSZDLPcQI4S3sd9
         Ggjbwqrkabv0mnpnuGaiQXtPZfRIPkch+OF4J3moIeEfgmZbH3BnRbhqQ8fV467bJm/z
         KBcuD1GuAGjtubGIP6SGNpEQm3DNNQHxQm6qoM+PWq+SW4mc8cbrqbyn1r9tmLiM+KA6
         BCDUQRw9yl9FS6OgYDoA79jKxC4bLnulMQPvkm0WzV5TzPHhsDvv/1lY3OkzFNRHkdYI
         i2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc;
        bh=IUW6YYxCAwdeHRIHDx1yJO8lcR2yG3Z47f18rm6Y2Ro=;
        b=DglS6RzwPbJX62841GOhYpWq3kkqB9zcw5EaRrp94VRCAE4/hMrqKWF+UaKpg78AuB
         UntDrsOK5hxwXB1nKq+UhkjkioyhwN53LcGaHth2RffsNoAvhERgWhTfg1OBMHVB5NTI
         2CHQVUjZFyhP2M1wH2cbsSxGhJZXyVc+eAyAGwMNfm7RiX2PQ5FfvohF/4pvJxv4gr08
         txTwL9mvNZLTuS6/xJhavmYeoOc0xgOTi+Xd+0BUAjrh56vegz5OBK8/cLBS3cSl8ylt
         VxJpOjM0UvKMcves1hhgKpkXOCCO5FxGt5L34egFGWciraodSOmuMJhmzylRsm6R1QdY
         55Lg==
X-Gm-Message-State: ACgBeo34ODtdpgryxwXagOn1Sxrzm7AW+rZqpENzhUao43d/C4VBHBm+
        Xuc+l23Feo98smqbR/S18rM=
X-Google-Smtp-Source: AA6agR7JcasLeCFMjvhsT/DPHdRcnq7ACi0zSLegzCBcaY3IY0bxcXvfNzQvNxpPVD41YdWMfi4SHQ==
X-Received: by 2002:a92:ce90:0:b0:2ea:c004:c396 with SMTP id r16-20020a92ce90000000b002eac004c396mr208376ilo.216.1661531048201;
        Fri, 26 Aug 2022 09:24:08 -0700 (PDT)
Received: from localhost ([172.243.153.43])
        by smtp.gmail.com with ESMTPSA id r6-20020a02b106000000b00349ea1c5fd1sm1060522jah.160.2022.08.26.09.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 09:24:07 -0700 (PDT)
Date:   Fri, 26 Aug 2022 09:23:57 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Qiao Ma <mqaio@linux.alibaba.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Message-ID: <6308f39ddfecc_75c920884@john.notmuch>
In-Reply-To: <CAADnVQKm-TGJxjwByaMBcvFA_7g+wC2hB+cqkZKhSc83a2H0Pg@mail.gmail.com>
References: <38269a1610deebf8d51127f15b1c55d00caa4283.1661392989.git.mqaio@linux.alibaba.com>
 <CAADnVQKm-TGJxjwByaMBcvFA_7g+wC2hB+cqkZKhSc83a2H0Pg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: fix incorrect fcntl call
 (test_sockmap.c)
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Alexei Starovoitov wrote:
> On Wed, Aug 24, 2022 at 7:11 PM Qiao Ma <mqaio@linux.alibaba.com> wrote:
> >
> > In test_sockmap.c, the testcase sets socket nonblock first, and then
> > calls select() and recvmsg() to receive data.
> > If some error occur, nonblock setting will make recvmsg() return
> > immediately, rather than blocking forever.
> >
> > However, the way to call fcntl() to set nonblock is wrong.
> > To set socket noblock, we need to use
> > > fcntl(fd, F_SETFL, O_NONBLOCK);
> > rather than:
> > > fcntl(fd, O_NONBLOCK);
> >
> > Signed-off-by: Qiao Ma <mqaio@linux.alibaba.com>
> > ---
> >  tools/testing/selftests/bpf/test_sockmap.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
> > index 0fbaccdc8861..abb4102f33b0 100644
> > --- a/tools/testing/selftests/bpf/test_sockmap.c
> > +++ b/tools/testing/selftests/bpf/test_sockmap.c
> > @@ -598,7 +598,12 @@ static int msg_loop(int fd, int iov_count, int iov_length, int cnt,
> >                 struct timeval timeout;
> >                 fd_set w;
> >
> > -               fcntl(fd, fd_flags);
> > +               err = fcntl(fd, F_SETFL, fd_flags);
> > +               if (err < 0) {
> > +                       perror("fcntl failed");
> > +                       goto out_errno;
> > +               }
> > +
> 
> John, Jakub,
> 
> Please review this.
> Unfortunately test_sockmap (and sockmap kernel) is broken
> before and after this patch,
> so I'm hesitant to apply it not to make thing harder to debug.
> Here is what I see:
> # ./test_sockmap
> recv failed(): Bad address
> rx thread exited with err 1.
> recv failed(): Bad address
> rx thread exited with err 1.
> recv failed(): Bad address
> rx thread exited with err 1.
> # 4/ 6  sockmap::txmsg test ingress redirect:FAIL
> detected skb data error with skb ingress update @iov[0]:0 "00 00 00
> 00" != "PASS"
> data verify msg failed: Unknown error -5
> rx thread exited with err 1.
> [   16.735850] ------------[ cut here ]------------
> [   16.736195] WARNING: CPU: 3 PID: 1480 at net/core/stream.c:205
> sk_stream_kill_queues+0x18a/0x1a0
> [   16.736799] Modules linked in:
> [   16.737007] CPU: 3 PID: 1480 Comm: test_sockmap Not tainted
> 5.19.0-14050-g343949e10798 #4212
> [   16.737543] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> [   16.738522] RIP: 0010:sk_stream_kill_queues+0x18a/0x1a0
> [   16.738883] Code: 41 5f c3 89 ee 48 89 df e8 13 69 fe ff 4c 89 e7
> e8 db 01 4f ff 8b ab 28 02 00 00 eb c1 0f 0b e9 62 ff ff ff 0f 0b 85
> ed 74 ce <0f> 0b 5b 5d 41 5c 41 5d 41 5e 41 5f c3 66 0f 1f 84 00 00 00
> 00 00
> [   16.740082] RSP: 0018:ffff888118007ab8 EFLAGS: 00010206
> [   16.740435] RAX: 0000000000000000 RBX: ffff8881174b2400 RCX: ffffffff81f5d47a
> [   16.740915] RDX: 0000000000000003 RSI: dffffc0000000000 RDI: ffff8881174b2670
> [   16.741374] RBP: 0000000000000b00 R08: fffffbfff08cfbdf R09: fffffbfff08cfbdf
> [   16.741841] R10: ffffffff8467def7 R11: fffffbfff08cfbde R12: ffff8881174b2628
> [   16.742298] R13: ffffffff85c13c00 R14: ffff88810611d824 R15: ffff8881174b25c8
> [   16.742768] FS:  00007f937403c400(0000) GS:ffff888628f80000(0000)
> knlGS:0000000000000000
> [   16.743283] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   16.743657] CR2: 00007f937403c378 CR3: 0000000125983005 CR4: 00000000003706e0
> [   16.744124] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   16.744584] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   16.745065] Call Trace:
> [   16.745241]  <TASK>
> [   16.745401]  inet_csk_destroy_sock+0x9f/0x1c0
> [   16.745707]  tcp_rcv_state_process+0x1a84/0x2120
> [   16.746013]  ? lock_release+0x3b0/0x3b0
> [   16.746271]  ? tcp_established_options+0x189/0x300
> [   16.746592]  ? tcp_finish_connect+0x240/0x240
> [   16.746894]  ? rcu_read_lock_bh_held+0xa0/0xa0
> [   16.747190]  ? rcu_read_lock_held_common+0x1a/0x50
> [   16.747505]  ? rcu_read_lock_sched_held+0x56/0xc0
> [   16.747823]  ? rcu_read_lock_held_common+0x1a/0x50
> [   16.748139]  ? lock_release+0xad/0x3b0
> [   16.748390]  ? __release_sock+0x83/0x150
> [   16.748646]  ? lock_downgrade+0x360/0x360
> [   16.748932]  ? lock_acquire+0xab/0x380
> [   16.749187]  ? lock_downgrade+0x360/0x360
> [   16.749440]  ? tcp_v4_do_rcv+0x195/0x4f0
> [   16.749696]  tcp_v4_do_rcv+0x195/0x4f0
> [   16.749933]  ? trace_hardirqs_on+0x2d/0xe0
> [   16.750194]  __release_sock+0xb9/0x150
> ...
> [  213.529908] ------------[ cut here ]------------
> [  213.530232] page_counter underflow: -7 nr_pages=31
> [  213.530571] WARNING: CPU: 1 PID: 1925 at mm/page_counter.c:57
> page_counter_cancel+0x56/0x80
> [  213.531125] Modules linked in:
> [  213.531332] CPU: 1 PID: 1925 Comm: test_sockmap Tainted: G        W
>          5.19.0-14050-g343949e10798 #4212
> [  213.531989] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> [  213.532734] RIP: 0010:page_counter_cancel+0x56/0x80
> [  213.533070] Code: 0a 48 89 df 5b 5d e9 89 fe ff ff 80 3d d1 b6 1e
> 03 00 75 18 48 89 ea 48 c7 c7 60 6a b3 82 c6 05 be b6 1e 03 01 e8 aa
> aa 0b 01 <0f> 0b be 08 00 00 00 48 89 df e8 bb 22 fe ff 48 89 df e8 13
> 1a fe
> [  213.534259] RSP: 0018:ffff88811ae2f8b0 EFLAGS: 00010086
> [  213.534607] RAX: 0000000000000000 RBX: ffff888100c08120 RCX: 0000000000000000
> [  213.535071] RDX: 0000000000000027 RSI: dffffc0000000000 RDI: ffffed10235c5f0c
> [  213.535535] RBP: 000000000000001f R08: ffffed10c51d4ee6 R09: ffffed10c51d4ee6
> [  213.536000] R10: ffff888628ea772b R11: ffffed10c51d4ee5 R12: ffff888628eb5d18
> [  213.536479] R13: ffff888628eb5d10 R14: ffff888628eb5d18 R15: 000000000000001f
> [  213.536953] FS:  00007fe0f0478400(0000) GS:ffff888628e80000(0000)
> knlGS:0000000000000000
> [  213.537463] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  213.537858] CR2: 00007fe0f04786d0 CR3: 000000011ab33004 CR4: 00000000003706e0
> [  213.538325] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  213.538838] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  213.539318] Call Trace:
> [  213.539488]  <TASK>
> [  213.539635]  page_counter_uncharge+0x1d/0x40
> [  213.539927]  drain_stock.isra.54+0x5d/0xb0
> [  213.540200]  __refill_stock+0x42/0xb0
> [  213.540451]  refill_stock+0xc1/0x1c0
> [  213.540688]  try_charge_memcg+0xb2e/0xb50
> 
> and test_sockmap 'hangs' (or doing something for long time) after
> #31/ 6 sockhash:ktls:txmsg test drop:OK

Thanks for spotting I'll take a look.
