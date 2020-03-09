Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28AED17DD03
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Mar 2020 11:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgCIKNJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Mar 2020 06:13:09 -0400
Received: from mail-qt1-f177.google.com ([209.85.160.177]:40729 "EHLO
        mail-qt1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgCIKNJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Mar 2020 06:13:09 -0400
Received: by mail-qt1-f177.google.com with SMTP id n5so2915947qtv.7
        for <linux-kselftest@vger.kernel.org>; Mon, 09 Mar 2020 03:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=648mzzepZ5tSc7PNa9qexy20DLiBZAL6qiw3uTe+M9w=;
        b=NmLcaECANXRQ7YWBo/2oKMW2s213Uwh0qWZPhPdxpXLEmxlc8GFWvY8B4hTSTj4apW
         BHBo5FZHE1FfHexAqkU87IdLs4K1rP9mterSyJxS1X32n2Na7+dx4Jk00WrFcX3B7Hk3
         OL95fFkRC7FCoeUx7yiLc7+6RNooCGQZbYT9IDQK8LMClIUTHbOuFsji2dz2A2fs0lUo
         pb6VZuxAkCU0mTWK8jOLfvONbWdT7Z4arTQjhuIQmHDjplHAcktEnGJpFl9dy+PuOTrU
         EJiCM3R+rFTdrXFG+/aP+GC8q925+6RU7N0cNrJW0UsqMU2foP41+mw9mIyDQo+EiLdO
         /rew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=648mzzepZ5tSc7PNa9qexy20DLiBZAL6qiw3uTe+M9w=;
        b=mv4610eq6Gcoo0EKzYfjMlR7Z7ZByY0jzNJZ5IS0gFJmk0fxcqGSWXnI3UBzo4d+D1
         pC32leaWQAdDVIcuMxde5C17+MYsAs5uJ/GGe1BRXLs14XafPfCzdQJ8NI2keM78vPA6
         +ioAcrc8BcBB+IUmjFSLHUWSRxs6Y3cz/CnxTxHw5qfgS4R1frAtYrZFvN9xTo9OEOU2
         p3dgrJMrL1cJ+v5Q6d1bwEuG7MPCbfyA6fhKGAxfH+UVP15N+H6/2xMt9JL+QptxeLkh
         NPU0kPZzkB1JllMrn5AcdxkMHERJAeG5mXzcVHMBTh46yM0rjKOjBnlzYeUz7VLfMZxh
         yvFQ==
X-Gm-Message-State: ANhLgQ1r1jWmxzvbQl0sENi2ir+GACqcBJobxLK01w2mi+ka+cV9+6Rp
        0NDRaOizFb10MUSZ9bYh+oKBNoATTb8=
X-Google-Smtp-Source: ADFU+vvK9BhA/tGuQekc9XOkrwhEPuel6MrPdQ9RaLEOano1eQIhDrZiCEN92z7Og25xgt8ALL/dFA==
X-Received: by 2002:ac8:534b:: with SMTP id d11mr13950419qto.101.1583748788478;
        Mon, 09 Mar 2020 03:13:08 -0700 (PDT)
Received: from dhcp-12-139.nay.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id t3sm20374416qkt.114.2020.03.09.03.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 03:13:08 -0700 (PDT)
From:   Hangbin Liu <liuhangbin@gmail.com>
To:     linux-kselftest@vger.kernel.org
Cc:     Shuah Khan <shuahkh@osg.samsung.com>,
        Hangbin Liu <liuhangbin@gmail.com>
Subject: [RFC PATCH 0/1] selftests/run_kselftest.sh: make each test individually selectable
Date:   Mon,  9 Mar 2020 18:12:55 +0800
Message-Id: <20200309101256.868-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, this patch enhanced the run_kselftest.sh to make the tests individually
selectable. I'm not sure the if I could add the reuslt in the patch commit,
as the log is too long. So I just put the result to the cover-letter:

Note: I use `tr -s "/-" "_"` to cover the path name in tests to function name.
e.g. networking/timestamping -> networking_timestamping. I'm not sure if it's
legal in Makefile.

Before the patch:

]# ./kselftest_install.sh /tmp/kselftests
]# cat /tmp/kselftests/run_kselftest.sh
#!/bin/sh
BASE_DIR=$(realpath $(dirname $0))
cd $BASE_DIR
. ./kselftest/runner.sh
ROOT=$PWD
if [ "$1" = "--summary" ]; then
  logfile=$BASE_DIR/output.log
  cat /dev/null > $logfile
fi
[ -w /dev/kmsg ] && echo "kselftest: Running tests in android" >> /dev/kmsg
cd android
run_many        \
        "run.sh"
cd $ROOT
...<snip>...
[ -w /dev/kmsg ] && echo "kselftest: Running tests in zram" >> /dev/kmsg
cd zram
run_many        \
        "zram.sh"
cd $ROOT

After the patch:
]# ./kselftest_install.sh /tmp/kselftests
]# cat /tmp/kselftests/run_kselftest.sh
#!/bin/sh
BASE_DIR=$(realpath $(dirname $0))
. ./kselftest/runner.sh
TESTS="android ...<snip>... zram"

run_android()
{
        [ -w /dev/kmsg ] && echo "kselftest: Running tests in android" >> /dev/kmsg
        cd android
        run_many        \
                "run.sh"
        cd $ROOT
}

...<snip>...

run_zram()
{
        [ -w /dev/kmsg ] && echo "kselftest: Running tests in zram" >> /dev/kmsg
        cd zram
        run_many        \
                "zram.sh"
        cd $ROOT
}

usage()
{
        cat <<EOF
usage: ${0##*/} OPTS
        -s | --summary          Only print summary info and put detailed log in output.log
        -t | --tests            Test name you want to run specifically
        -h | --help             Show this usage info
EOF
}

while true; do
        case "$1" in
        -s | --summary ) logfile=$BASE_DIR/output.log; cat /dev/null > $logfile; shift ;;
        -t | --tests ) TESTS=$2; shift 2 ;;
        -h | --help ) usage; exit 0;;
        "" ) break;;
        * ) usage; exit 1;;
        esac
done

cd $BASE_DIR
ROOT=$PWD
for test in $TESTS; do
        run_$test
done


Hangbin Liu (1):
  selftests/run_kselftest.sh: make each test individually selectable

 tools/testing/selftests/Makefile | 48 +++++++++++++++++++++++++-------
 tools/testing/selftests/lib.mk   |  2 +-
 2 files changed, 39 insertions(+), 11 deletions(-)

-- 
2.19.2

