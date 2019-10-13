Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE574D53BD
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Oct 2019 03:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfJMB7f (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 12 Oct 2019 21:59:35 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:32851 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727440AbfJMB7f (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 12 Oct 2019 21:59:35 -0400
Received: by mail-pl1-f194.google.com with SMTP id d22so6340216pls.0
        for <linux-kselftest@vger.kernel.org>; Sat, 12 Oct 2019 18:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=m2MGPURxbEY+Lo7/XApKCvoc6WjY0Fk057Fhqw5Lysk=;
        b=ax9Lxlwb3pem9AEVfv62nlde5APoJfuDh363S83LBSq9pfpCsoJC4Nfm4GPQS2vrP9
         KVljdu2lGciyyV56YJfUx91Tn1RR4/9O7iKt7S/XDER6XVdMpMRLWlpJwAVfFdGWt8FP
         D84AoyqLnYapXdySIH3CKkXjg1h7M2Xq3kIWXSlfKFkd53BE2TgX+sBMosK0vIrZxkyI
         et4h6M47bx2HEiceZUqNelk40vuqtHonQsqEiji1+yLc6EWTAbCN9unCud7RKFCgMGij
         s8SqzIC01HlRCXK4WJwmRjyXuP7HWixxIsZHQemtb6Of0WJsaG6DImlIWyNPsNTe8fGz
         BhfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=m2MGPURxbEY+Lo7/XApKCvoc6WjY0Fk057Fhqw5Lysk=;
        b=e5SKVRj2o00ymdDYy64CzgCU+NX7Su0ZkiOq0Z7bKMQl53jJkW3/Qv9AuKtjJqQgug
         t5gav6dAzEIjjMT4M6Ik6FDYaVKNoUQjoQy9K0r26LYHAJGAYVBhzcCjhhbQrKvEzWuj
         XjIutNWZ4m8sQ3GO80LizT378sag2YgPERh1sklQkmfScwu6nqT5sst58HBDfpzuDWWf
         JnOvHLKWaCKf/dAD+ofH8FMyxgk9XQmowo+q1llS564HrQQgS1phnv+MrQjKKRCJQ1tG
         G9ZqxaSiVdK4TXzNBbw+2II/QcTZ6Vh6ES04tm9HC1DGgQYmA178L2KrFDSWjsemy8NC
         qgkw==
X-Gm-Message-State: APjAAAUzqr6yJW7fR78HRpEk9aoHu6DsUOOKmHVg0zSFlxvH5qecNvwQ
        rdXCfaXXDsyyT1Yb/0h3LbgpFaTb
X-Google-Smtp-Source: APXvYqyFoxv3Ge1bO3inw0iu3OxssE+Y6UBzqYwQgkYJqFRQcBHsXl1iDlVEnCfui+k+gkzNs79dWQ==
X-Received: by 2002:a17:902:b08f:: with SMTP id p15mr22032677plr.229.1570931974083;
        Sat, 12 Oct 2019 18:59:34 -0700 (PDT)
Received: from [192.168.31.113] ([43.224.157.59])
        by smtp.gmail.com with ESMTPSA id u3sm13403334pfn.134.2019.10.12.18.59.33
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Oct 2019 18:59:33 -0700 (PDT)
To:     linux-kselftest@vger.kernel.org
From:   Prabhakar Kushwaha <prabhakar.pkin@gmail.com>
Subject: kseltest: bpf: test_lwt_ip_encap.sh: Why -l used in test_gso
Message-ID: <731bcbd4-0e01-245a-8f8d-bec8024868ca@gmail.com>
Date:   Sun, 13 Oct 2019 07:29:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi All,

I am trying to understand test_gso test for IPv4 and IPv6 with following 
piece of code

       # listen on IPv*_DST, capture TCP into $TMPFILE
         if [ "${PROTO}" == "IPv4" ] ; then
                 IP_DST=${IPv4_DST}
                 ip netns exec ${NS3} bash -c \
                        "nc -4 -l -s ${IPv4_DST} -p 9000 > ${TMPFILE} &"
         elif [ "${PROTO}" == "IPv6" ] ; then
                 IP_DST=${IPv6_DST}
                 ip netns exec ${NS3} bash -c \
                        "nc -6 -l -s ${IPv6_DST} -p 9000 > ${TMPFILE} &"
                 RET=$?
         else
                 echo "    test_gso: unknown PROTO: ${PROTO}"
	fi

I have couple of queries around it

a) why -l is being used for reading listen on IPv*_DST with -s option.
I was looking at https://www.computerhope.com/unix/nc.htm, following has 
been mentioned:
-l :  Used to specify that nc should listen for an incoming connection 
rather than initiate a connection to a
remote host. It is an error to use this option in conjunction with the 
-p, -s, or -z options.
Additionally, any timeouts specified with the -w option are ignored.

b) Even if there is requirement of -l option to use. can we provide 
timeout option also. how? as -w dont work with -l.


I am facing an issue with Linux-5.3 Kselftest where even if 
test_lwt_ip_encap.sh "exit", bpf/runner.sh is not
running next test case. It just wait until CRTL + c is pressed.
If I comment above code things work fine.


Please sugggest

--prabhakar (pk)
