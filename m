Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1FDD5B68
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2019 08:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfJNGdz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Oct 2019 02:33:55 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:11565 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726406AbfJNGdz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Oct 2019 02:33:55 -0400
X-IronPort-AV: E=Sophos;i="5.67,294,1566835200"; 
   d="scan'208";a="76933795"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 14 Oct 2019 14:33:53 +0800
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
        by cn.fujitsu.com (Postfix) with ESMTP id 47EBA4CE1507;
        Mon, 14 Oct 2019 14:33:34 +0800 (CST)
Received: from localhost.localdomain (10.167.226.81) by
 G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Mon, 14 Oct 2019 14:33:50 +0800
Subject: Re: kseltest: bpf: test_lwt_ip_encap.sh: Why -l used in test_gso
To:     Prabhakar Kushwaha <prabhakar.pkin@gmail.com>,
        <linux-kselftest@vger.kernel.org>
References: <731bcbd4-0e01-245a-8f8d-bec8024868ca@gmail.com>
From:   Liu Yiding <liuyd.fnst@cn.fujitsu.com>
Message-ID: <3c6ba815-6d95-e550-2983-ee40790ec495@cn.fujitsu.com>
Date:   Mon, 14 Oct 2019 14:34:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <731bcbd4-0e01-245a-8f8d-bec8024868ca@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-yoursite-MailScanner-ID: 47EBA4CE1507.A998D
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: liuyd.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Kushwaha.


On 10/13/19 9:59 AM, Prabhakar Kushwaha wrote:
> Hi All,
>
> I am trying to understand test_gso test for IPv4 and IPv6 with 
> following piece of code
>
>       # listen on IPv*_DST, capture TCP into $TMPFILE
>         if [ "${PROTO}" == "IPv4" ] ; then
>                 IP_DST=${IPv4_DST}
>                 ip netns exec ${NS3} bash -c \
>                        "nc -4 -l -s ${IPv4_DST} -p 9000 > ${TMPFILE} &"
>         elif [ "${PROTO}" == "IPv6" ] ; then
>                 IP_DST=${IPv6_DST}
>                 ip netns exec ${NS3} bash -c \
>                        "nc -6 -l -s ${IPv6_DST} -p 9000 > ${TMPFILE} &"
>                 RET=$?
>         else
>                 echo "    test_gso: unknown PROTO: ${PROTO}"
>     fi
>
> I have couple of queries around it
>
> a) why -l is being used for reading listen on IPv*_DST with -s option.
> I was looking at https://www.computerhope.com/unix/nc.htm, following 
> has been mentioned:
> -l :  Used to specify that nc should listen for an incoming connection 
> rather than initiate a connection to a
> remote host. It is an error to use this option in conjunction with the 
> -p, -s, or -z options.
> Additionally, any timeouts specified with the -w option are ignored.
>
> b) Even if there is requirement of -l option to use. can we provide 
> timeout option also. how? as -w dont work with -l.
>
>
> I am facing an issue with Linux-5.3 Kselftest where even if 
> test_lwt_ip_encap.sh "exit", bpf/runner.sh is not
> running next test case. It just wait until CRTL + c is pressed.


I meet same issue. "make run_tests -C bpf" bpf/runner.sh hang on 
test_lwt_ip_encap.sh. And when i skip it,

test_tc_tunnel.sh also has this problem.


> If I comment above code things work fine.
>
>
> Please sugggest
>
> --prabhakar (pk)
>
>
-- 
Best regards.
Liu Yiding



